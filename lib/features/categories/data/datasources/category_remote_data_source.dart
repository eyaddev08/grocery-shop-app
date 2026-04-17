import '../../../../core/error/exception.dart';
import '../models/category_model.dart';
import 'dart:convert';
import 'package:flutter/services.dart';

abstract class CategoryRemoteDataSource {
  Future<List<CategoryModel>> getCategories();
}

class CategoryRemoteDataSourceImpl implements CategoryRemoteDataSource {
  @override
  Future<List<CategoryModel>> getCategories() async {
    try {
      final String jsonString =
          await rootBundle.loadString('assets/mock_api/category_mock.json');
      final Map<String, dynamic> jsonMap =
          json.decode(jsonString) as Map<String, dynamic>;

      final List<dynamic> jsonList =
          jsonMap['categories']['data'] as List<dynamic>;

      return jsonList
          .map((jsonItem) =>
              CategoryModel.fromJson(jsonItem as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw ServerException('Error parsing categories JSON');
    }
  }
}
