import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../../domain/entities/category_entity.dart';

part 'category_model.g.dart';

@HiveType(typeId: 5)
class CategoryModel extends HiveObject {
  CategoryModel({
    required this.id,
    required this.name,
    required this.subName,
    required this.tag,
    required this.thumbnail,
    required this.price,
    required int colorValue,
    // this.productIds = const [],
  }) : colorValue = colorValue;

  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String subName;
  @HiveField(3)
  final String tag;
  @HiveField(4)
  final String? thumbnail;
  @HiveField(5)
  final String price;
  @HiveField(6)
  final int colorValue;
  // final List<String> productIds;

  Color get color => Color(colorValue);

  CategoryModel copyWith({List<String>? productIds}) => CategoryModel(
        id: id,
        name: name,
        subName: subName,
        tag: tag,
        thumbnail: thumbnail,
        price: price,
        colorValue: colorValue,
        // productIds: productIds ?? this.productIds,
      );

  factory CategoryModel.fromCategory(CategoryEntity category) => CategoryModel(
        id: category.id,
        name: category.name,
        subName: category.subName,
        tag: category.tag,
        thumbnail: category.thumbnail,
        price: category.price,
        colorValue: category.color.value,
        // productIds: category.productIds,
      );

  CategoryEntity toEntity() => CategoryEntity(
        id: id,
        name: name,
        subName: subName,
        tag: tag,
        thumbnail: thumbnail,
        price: price,
        color: color,
        // productIds: productIds,
      );

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
    id: json['id']?.toString() ?? '',
        name: json['name'] as String? ?? '',
        subName: json['subName'] as String? ?? '',
        tag: json['tag'] as String? ?? '',
        thumbnail: json['thumbnail'] as String?,
        price: json['price']?.toString() ?? '0',
        colorValue: _parseColor(json['color']),
        // productIds: List<String>.from(json['productIds'] as List<dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'subName': subName,
        'tag': tag,
        'thumbnail': thumbnail,
        'price': price,
        'color': colorValue,
        // 'productIds': productIds,
      };

      static int _parseColor(dynamic colorValue) {
    if (colorValue is int) return colorValue; 
    
    if (colorValue is String) {
      String hex = colorValue.replaceAll('#', '').replaceAll('0x', '');
      
      if (hex.length == 6) {
        hex = 'FF$hex';
      }
      
      return int.tryParse(hex, radix: 16) ?? 0xFF000000; 
    }
    
    return 0xFF000000;
  }
}
  