import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/category.dart';

abstract class CategoryRepository {
  Future<Either<Failure, List<Category>>> getCategories();
}
