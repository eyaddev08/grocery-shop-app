import 'dart:convert';
import 'package:flutter/services.dart';

import '../../../../core/error/exception.dart';
import '../models/product_model.dart';

abstract class ProductRemoteDataSource {
  Future<List<ProductModel>> getProducts();
  Future<List<ProductModel>> getRecommendedProducts();
  Future<List<ProductModel>> getDealsProducts();

}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  static const String _mockPath = 'assets/mock_api/product_mock.json';

  Future<List<ProductModel>> _loadMockData(String jsonKey, {bool isNestedData = false}) async {
    try {
      await Future<void>.delayed(const Duration(milliseconds: 500));
      final String jsonString = await rootBundle.loadString(_mockPath);
      final Map<String, dynamic> jsonMap = json.decode(jsonString) as Map<String, dynamic>;

      final List<dynamic> jsonList = isNestedData 
          ? jsonMap[jsonKey]['data'] as List<dynamic>
          : jsonMap[jsonKey] as List<dynamic>;

      return jsonList.map((item) => ProductModel.fromJson(item as Map<String, dynamic>)).toList();
    } catch (e) {
      throw ServerException('Error parsing $jsonKey JSON');
    }
  }

  @override
  Future<List<ProductModel>> getProducts() => 
      _loadMockData('products', isNestedData: true);

  @override
  Future<List<ProductModel>> getRecommendedProducts() => 
      _loadMockData('recommended');

  @override
  Future<List<ProductModel>> getDealsProducts() => 
      _loadMockData('deals');
}
