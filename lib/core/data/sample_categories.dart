// lib/data/sample_categories.dart
import 'package:flutter/material.dart';

import '../../features/categories/domain/entities/category.dart';

// Keep the original list you provided but now include productIds

///  - '1' => Big & Small Fishes
///  - '2' => Vegetables
///  - '3' => Meats
///  - '4' => Organic Eggs
///  - '6' => Fruits
final List<Category> sampleCategories = [
  const Category(
    id: '1',
    title: 'Big & Small Fishes',
    subtitle: 'Fresh from sea',
    filterName: 'Fishes',
    image:
        'https://drive.google.com/uc?export=view&id=1Iad6X8-hckjPK9QfZZwQnCe-Lfvljbck', // Gala apple example

    price: '36',
    color: Color(0xFFFFC3BB),
  ),

  const Category(
    id: '2',
    title: 'Vegetables',
    subtitle: 'Fresh & Seasonal',
    filterName: 'Vegetables',
    // you can use ImagesConstants or a Drive link
    image:
        'https://drive.google.com/uc?export=view&id=1PFvykX2m5s15V4B5N1h7A8OgQZDcxp7f',
    price: 'Varies',
    color: Color(0xFFD8F5D1),
  ),

  const Category(
    id: '3',
    title: 'Meats',
    subtitle: 'Organic & Halal',
    filterName: 'Meats',
    image:
        'https://drive.google.com/uc?export=view&id=1wik3_sOhRe2TuSMdE36qz9OixHLf3fbm',

    price: 'Varies',
    color: Color(0xFFFFDC82),
  ),

  const Category(
    id: '4',
    title: 'Organic Eggs',
    subtitle: 'Fresh & Organic',
    filterName: 'Eggs',
    image:
        'https://drive.google.com/uc?export=view&id=1HTUdqZYmSZ3uD56mKnU2YoRM_8C-MalS',
    price: 'Varies',
    color: Color(0xFFEFFAC5),
  ),

  // Fruits category (id = '6') to match productsListFruitsAndMeats entries
  const Category(
    id: '6',
    title: 'Fruits',
    subtitle: 'Fresh & Juicy',
    filterName: 'Fruits',
    image:
        'https://drive.google.com/uc?export=view&id=1b1ry2ROxoT149QjdHB_a0TN6WoCTDqU6', // Gala apple example
    price: 'Varies',
    color: Color(0xFFFFF1C8),
  ),
];
// final List<Category> sampleCategories = [
//   const Category(
//     id: '1',
//     title: 'Big & Small Fishes',
//     subtitle: 'Fresh from sea',
//     filterName: 'Meats & Fishes',
//     image: ImagesConstants.freshBassWhiteBg,
//     price: '36',
//     color: Color(0xFFFFC3BB),
//     // productIds: [
//     //   'f1',
//     //   'f2',
//     //   'f3',
//     //   'f4',
//     //   'f5',
//     //   'f6',
//     //   'f7',
//     //   'f8',
//     //   'f9',
//     //   'f10'
//     // ], // fish ids
 
//   ),
//   const Category(
//     id: '2',
//     title: 'Halal Meats',
//     subtitle: 'Organics & Fresh',
//     filterName: 'Meats',
//     image: ImagesConstants.rawMeatAssortment,
//     price: '90',
//     color: Color(0xFFFFDC82),
//     // productIds: [], // attach meat product ids when available
//   ),
//   const Category(
//     id: '3',
//     title: 'Meats',
//     subtitle: 'Organic',
//     filterName: 'Meats',
//     image: ImagesConstants.freshBeefCubes,
//     price: '36',
//     color: Color(0xFFEFFAC5),
//     // productIds: [], // attach meat product ids when available
//   ),
//   const Category(
//     id: '4',
//     title: 'Organic Eggs',
//     subtitle: 'Fresh & Organic',
//     filterName: 'Fruits',
//     image: null,
//     price: '36',
//     color: Color(0xFFEFFAC5),
//     // productIds: [], // attach egg product ids when available
//   ),
//   // New category for Vegetables (recommended)
//   const Category(
//     id: '5',
//     title: 'Vegetables',
//     subtitle: 'Fresh & Seasonal',
//     filterName: 'Vegetables',
//     image: ImagesConstants.vegetablesBasket,
//     price: 'Varies',
//     color: Color(0xFFD8F5D1),
//     // productIds: ['v1', 'v2', 'v3', 'v4', 'v5', 'v6', 'v7', 'v8', 'v9', 'v10'],
//   ),
// ];
