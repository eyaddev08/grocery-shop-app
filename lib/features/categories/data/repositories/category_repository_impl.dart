import 'package:flutter/material.dart';

import '../../domain/entities/category.dart';
import '../../domain/repositories/category_repository.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/utils/either.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  // simple in-memory sample data
  final List<Category> _sample = const [
    Category(
      id: '1',
      title: 'Big & Small Fishes',
      subtitle: 'Fresh from sea',
      filterName: 'Meats & Fishes',
      image: null,
      price: '36',
      color: Color(0xFFFFC3BB),
    ),
    Category(
      id: '2',
      title: 'Halal Meats',
      subtitle: 'Organics & Fresh',
      filterName: 'Vegetables',
      image: null,
      price: '90',
      color: Color(0xFFFFDC82),
    ),
    Category(
        id: '3',
        title: 'Meats',
        subtitle: 'Organic',
        filterName: 'Fruits',
        image: null,
        price: '36',
        color: Color(0xFFEFFAC5)),
    Category(
        id: '4',
        title: 'Organic Eggs',
        subtitle: 'Fresh & Organic',
        filterName: 'Fruits',
        image: null,
        price: '36',
        color: Color(0xFFEFFAC5)),
  ];

  @override
  Future<Either<Failure, List<Category>>> getCategories() async {
    // simulate small delay and return Right
    await Future<void>.delayed(const Duration(milliseconds: 150));
    return Right(_sample);
  }
}



//  final List<Category> _sample = const [
//     Category(id: '1', title: 'Fishes', subtitle: 'From Sea', image: null),
//     Category(id: '2', title: 'Vegetables', subtitle: 'Organic', image: null),
//     Category(
//         id: '3', title: 'Fruits', subtitle: 'Fresh & Organic', image: null),
//     Category(id: '4', title: 'Meats', subtitle: 'Organic', image: null),
//     Category(id: '5', title: 'Juices', subtitle: 'Cold-pressed', image: null),
//     Category(
//         id: '6', title: 'Cooking needs', subtitle: 'Essentials', image: null),
//   ];