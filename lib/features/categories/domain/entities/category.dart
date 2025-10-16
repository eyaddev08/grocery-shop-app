import 'package:flutter/material.dart';

class Category {
  final String id;
  final String title;
  final String subtitle;
  final String filterName;
  final String price;
  final String? image; // asset path or network url

  final Color color;
  const Category({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.filterName,
    required this.price,
    required this.color,
    this.image,
  });
}
