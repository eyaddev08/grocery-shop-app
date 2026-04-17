import 'dart:convert';

import 'package:dio/dio.dart';

import '../../../../core/error/exception.dart';
import '../../../../core/error/failure.dart';
import '../models/search_result_model.dart';
import '../models/suggestion_model.dart';

abstract class SearchRemoteDataSource {
  Future<List<SuggestionModel>> getSuggestions(String query,
      {CancelToken? cancelToken});
  Future<SearchResultModel> search({
    required String query,
    Map<String, dynamic>? filters,
    String? cursor,
    int? limit,
    String? sort,
    CancelToken? cancelToken,
  });
}

class SearchRemoteDataSourceImpl implements SearchRemoteDataSource {
  SearchRemoteDataSourceImpl({required this.client, this.baseUrl = ''});
  final Dio client;
  final String baseUrl;

  @override
  Future<List<SuggestionModel>> getSuggestions(String query,
      {CancelToken? cancelToken}) async {
    try {
      final params = {'q': query, 'limit': 0};
      Response<dynamic> response;
      try {
        response = await client.get('/api/search/suggestions',
            queryParameters: params, cancelToken: cancelToken);
      } on DioException catch (e) {
        if (e.response?.statusCode == 404) {
          response = await client.get('/api/search',
              queryParameters: params, cancelToken: cancelToken);
        } else {
          rethrow;
        }
      }
      if (response.statusCode != 200) throw ServerFailure('No data found');
      final map = _toMap(response.data) ?? {};
      final raw = map['suggestions'] ?? <List<dynamic>>[];
      if (raw is Iterable) {
        return SuggestionModel.fromJsonList(List<dynamic>.from(raw));
      }
      if (raw is String) {
        try {
          final decoded = jsonDecode(raw);
          if (decoded is Iterable) {
            return SuggestionModel.fromJsonList(List<dynamic>.from(decoded));
          }
        } catch (_) {}
      }
      return <SuggestionModel>[];
    } catch (e) {
      if (e is DioException) {
        if (e.type == DioExceptionType.cancel)
          throw ServerException.fromDioError(e);
      }
      throw ServerFailure(e.toString());
    }
  }

  @override
  Future<SearchResultModel> search({
    required String query,
    Map<String, dynamic>? filters,
    String? cursor,
    int? limit,
    String? sort,
    CancelToken? cancelToken,
  }) async {
    try {
      final params = <String, dynamic>{'q': query};
      if (limit != null) params['limit'] = limit;
      if (cursor != null) params['cursor'] = cursor;
      if (sort != null) params['sort'] = sort;
      if (filters != null) {
        filters.forEach((k, v) {
          params['filters[$k]'] = v;
        });
      }
      final response = await client.get<Map<String, dynamic>>('/api/search',
          queryParameters: params, cancelToken: cancelToken);
      if (response.statusCode != 200) throw ServerFailure('No data found');
      final Map<String, dynamic>? map = _toMap(response.data);
      if (map == null) throw ServerFailure('No data found');
      return SearchResultModel.fromJson(map);
    } on DioException catch (e) {
      throw ServerException.fromDioError(e);
    } catch (e) {
      throw ServerFailure(e.toString());
    }
    ServerFailure('No data found');
  }

  Map<String, dynamic>? _toMap(dynamic data) {
    if (data == null) return null;
    if (data is Map<String, dynamic>) return data;
    if (data is Map) return Map<String, dynamic>.from(data);
    if (data is String) {
      try {
        final decoded = jsonDecode(data);
        if (decoded is Map) return Map<String, dynamic>.from(decoded);
      } catch (_) {}
    }
    return null;
  }
}
