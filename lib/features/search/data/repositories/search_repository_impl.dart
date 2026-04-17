import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../core/error/exception.dart';
import '../../../../core/error/failure.dart';
import '../../domain/entities/suggestion.dart';
import '../../domain/entities/search_result.dart';
import '../../domain/repositories/search_repository.dart';
import '../datasources/search_local_data_source.dart';
import '../datasources/search_remote_data_source.dart';

class SearchRepositoryImpl implements SearchRepository {

  SearchRepositoryImpl({
    this.remoteDataSource,
    this.localDataSource,
  });

  final SearchRemoteDataSource? remoteDataSource;
  final SearchLocalDataSource? localDataSource;

  @override
  Future<Either<Failure, List<Suggestion>>> getSuggestions(String query) async {
    final q = query.trim();

    if (remoteDataSource != null) {
      try {
        final remote = await remoteDataSource!.getSuggestions(q);
        final List<Suggestion> results = remote
            .map((m) =>
                Suggestion(text: m.text, type: m.type, subtitle: m.subtitle))
            .toList();
        try {
          await localDataSource?.cacheSuggestions(remote);
        } catch (_) {}
        return Right(results);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      }
    }
    return Left(ServerFailure('Remote data source is not available'));
  }

  @override
  Future<Either<Failure, SearchResult>> search({
    required String query,
    Map<String, dynamic>? filters,
    String? cursor,
    int limit = 20,
    String sort = 'relevance',
  }) async {
    final q = query.trim();

    if (remoteDataSource != null) {
      try {
        final remoteModel = await remoteDataSource!.search(
          query: q,
          filters: filters,
          cursor: cursor,
          limit: limit,
          sort: sort,
        );

        if (cursor == null && localDataSource != null) {
          try {
            await localDataSource!.cacheLastResult(remoteModel);
          } catch (_) {}

          if (q.isNotEmpty) {
            try {
              await localDataSource!.addSearchToHistory(q);
            } on CacheException {
        return left(CacheFailure('No internet and no cached data'));
      }
          }
        }

        return Right(remoteModel);
      } on ServerException catch (e) {
        return left(ServerFailure(e.message));
      }
    }

    return Left(ServerFailure('Remote data source not available.'));
  }

  @override
  Future<Either<Failure, List<String>>> getSearchHistory() async {
     try {
       if (localDataSource != null) {
         final history = await localDataSource!.getSearchHistory();
         return Right(history);
       }
       return const Right([]);
     } catch (e) {
       return Left(CacheFailure( e.toString()));
     }
  }

  @override
  Future<Either<Failure, void>> addSearchToHistory(String query) async {
    try {
      if (localDataSource != null) {
        await localDataSource!.addSearchToHistory(query);
      }
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure( e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> clearSearchHistory() async {
    try {
      if (localDataSource != null) {
        await localDataSource!.clearSearchHistory();
      }
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure( e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> removeSearchHistoryItem(String item) async {
    try {
      if (localDataSource != null) {
        await localDataSource!.removeSearchHistoryItem(item);
      }
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure( e.toString()));
    }
  }
}
