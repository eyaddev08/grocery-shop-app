import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../../../../core/error/exception.dart';
import '../models/product_model.dart';

abstract class ProductLocalDataSource {
  Future<void> cacheProducts(List<ProductModel> products);
  Future<List<ProductModel>> getLastProducts();
  Future<void> cacheDealsProducts(List<ProductModel> dealsProducts);
  Future<List<ProductModel>> getLastDealsProducts();
  Future<void> cacheRecommendedProducts(List<ProductModel> recommendedProduct);
  Future<List<ProductModel>> getLastRecommendedProducts();
}

class ProductLocalDataSourceImpl implements ProductLocalDataSource {
  ProductLocalDataSourceImpl(this.box);
  final Box<dynamic> box;

  static const String _productsKey = 'cached_products';
  static const String _dealsKey = 'cached_deals';
  static const String _recommendedKey = 'cached_recommended';

  Future<void> _cacheList(String key, List<ProductModel> items) async {

    await box.put(key, items.map((e) => e.toJson()).toList()); 
  }

  Future<List<ProductModel>> _getCachedList(String key) async {
    try {
      final raw = box.get(key);
      if (raw != null && raw is List) {
        return raw.map((item) {
          if (item is ProductModel) return item;
          return ProductModel.fromJson(Map<String, dynamic>.from(item as Map));
        }).toList();
      }
      return [];
    } catch (e) {
      debugPrint('Cache Error for $key: $e');
      throw CacheException(); 
    }
  }

  
  @override
  Future<void> cacheProducts(List<ProductModel> products) => _cacheList(_productsKey, products);

  @override
  Future<List<ProductModel>> getLastProducts() => _getCachedList(_productsKey);

  @override
  Future<void> cacheDealsProducts(List<ProductModel> dealsProducts) => _cacheList(_dealsKey, dealsProducts);

  @override
  Future<List<ProductModel>> getLastDealsProducts() => _getCachedList(_dealsKey);

  @override
  Future<void> cacheRecommendedProducts(List<ProductModel> recommendedProducts) => _cacheList(_recommendedKey, recommendedProducts);

  @override
  Future<List<ProductModel>> getLastRecommendedProducts() => _getCachedList(_recommendedKey);
}
