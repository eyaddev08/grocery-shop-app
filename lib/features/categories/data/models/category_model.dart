// import 'package:flutter/material.dart';

// class CategoryModel {
//   final String id;
//   final String title;
//   final String subtitle;
//   final String filterName;
//   final String? image; // can be asset or network url
//   final String price;
//   final Color color;
//   final List<String> productIds; // list of product ids that belong to this category

//   const CategoryModel({
//     required this.id,
//     required this.title,
//     required this.subtitle,
//     required this.filterName,
//     required this.image,
//     required this.price,
//     required this.color,
//     this.productIds = const [],
//   });

//   CategoryModel copyWith({List<String>? productIds}) =>
//       CategoryModel(
//         id: id,
//         title: title,
//         subtitle: subtitle,
//         filterName: filterName,
//         image: image,
//         price: price,
//         color: color,
//         productIds: productIds ?? this.productIds,
//       );
// }

// lib/models/category_with_products.dart
import '../../../products/domain/entities/product_entity.dart';
import '../../domain/entities/category.dart';

class CategoryWithProducts {
  const CategoryWithProducts({
    required this.category,
    required this.products,
  });
  final Category category;
  final List<ProductEntity> products;
}