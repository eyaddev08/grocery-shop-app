import 'package:flutter/material.dart';

class CategoryEntity {
  const CategoryEntity({
    required this.id,
    required this.name,
    required this.subName,
    required this.tag,
    required this.price,
    required this.color,
    this.thumbnail,
  });
  final String id;
  final String name;
  final String subName;
  final String tag;
  final String price;
  final String? thumbnail;

  final Color color;

  
}
