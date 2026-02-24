import 'package:dartz/dartz.dart';
import '../../../../core/data/sample_categories.dart';
import '../../domain/entities/category.dart';
import '../../domain/repositories/category_repository.dart';
import '../../../../core/error/failure.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  // // simple in-memory sample data
  // final List<Category> _sample = const [
  //   Category(
  //     id: '1',
  //     title: 'Big & Small Fishes',
  //     subtitle: 'Fresh from sea',
  //     filterName: 'Meats & Fishes',
  //     image: ImagesConstants.freshBassWhiteBg,
  //     price: '36',
  //     color: Color(0xFFFFC3BB),
  //   ),
  //   Category(
  //     id: '2',
  //     title: 'Halal Meats',
  //     subtitle: 'Organics & Fresh',
  //     filterName: 'Meats',
  //     image: ImagesConstants.rawMeatAssortment,
  //     price: '90',
  //     color: Color(0xFFFFDC82),
  //   ),
  //   Category(
  //       id: '3',
  //       title: 'Meats',
  //       subtitle: 'Organic',
  //       filterName: 'Meats',
  //       image: ImagesConstants.freshBeefCubes,
  //       price: '36',
  //       color: Color(0xFFEFFAC5)),
  //   Category(
  //       id: '4',
  //       title: 'Organic Eggs',
  //       subtitle: 'Fresh & Organic',
  //       filterName: 'Fruits',
  //       image: null,
  //       price: '36',
  //       color: Color(0xFFEFFAC5)),
  // ];

  @override
  Future<Either<Failure, List<Category>>> getCategories() async {
    // simulate small delay and return Right
    await Future<void>.delayed(const Duration(milliseconds: 1500));
    return Right(sampleCategories);
  }
}
