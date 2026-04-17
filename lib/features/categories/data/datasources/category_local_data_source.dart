import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/category_model.dart';

abstract class CategoryLocalDataSource {
  Future<void> cacheCategories(List<CategoryModel> categories);
  Future<List<CategoryModel>> getLastCategories();
}

class CategoryLocalDataSourceImpl implements CategoryLocalDataSource {
  CategoryLocalDataSourceImpl(this.box);

  final Box<dynamic> box;
  static const String _key = 'cached_categories';

  @override
  Future<void> cacheCategories(List<CategoryModel> categories) async {
    await box.put(_key, categories);
  }

  @override
  Future<List<CategoryModel>> getLastCategories() async {
    try {
      final raw = box.get(_key);
      if (raw is List) {
        final List<CategoryModel> categories = [];
        for (final item in raw) {
          try {
            if (item is CategoryModel) {
              categories.add(item);
            } else if (item is Map) {
              final category = CategoryModel.fromJson(
                Map<String, dynamic>.from(item),
              );
              categories.add(category);
            }
          } catch (e) {
            debugPrint('Error parsing Category item: $e');
          }
        }
        return categories;
      }
    } catch (e) {
      debugPrint('Error in getLastCategories: $e');
    }
    return <CategoryModel>[];
  }
}
