import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/product_model.dart';

abstract class ProductLocalDataSource {
  Future<void> cacheProducts(List<ProductModel> products);
  Future<List<ProductModel>> getLastProducts();
}

class ProductLocalDataSourceImpl implements ProductLocalDataSource {
  final Box<dynamic> box;
  static const String _key = 'cached_products';

  ProductLocalDataSourceImpl(this.box);

  @override
  Future<void> cacheProducts(List<ProductModel> products) async {
    await box.put(_key, products);
  }

  @override
  Future<List<ProductModel>> getLastProducts() async {
    try {
      final raw = box.get(_key);
      if (raw is List) {
        final List<ProductModel> products = [];
        for (final item in raw) {
          try {
            if (item is Map) {
              final product = ProductModel.fromJson(
                Map<String, dynamic>.from(item),
              );
              products.add(product);
            }
          } catch (e) {
            // تجاهل العناصر التالفة فقط، وليس القائمة بأكملها
            debugPrint('Error parsing Product item: $e');
          }
        }
        return products;
      }
    } catch (e) {
      // في حالة الخطأ العام في القراءة
      return <ProductModel>[];
    }
    return <ProductModel>[];
  }
  //   final dynamic data = box.get(_key);
  //   if (data != null && data is List) {
  //     try {
  //       return data.cast<ProductModel>().toList();
  //     } catch (e) {
  //       return [];
  //     }
  //   }
  //   return [];
  // }
}
