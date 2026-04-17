import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/category_entity.dart';
import '../repositories/category_repository.dart';

class GetCategoriesUseCase {
  GetCategoriesUseCase(this.repository);
  final CategoryRepository repository;

  Future<Either<Failure, List<CategoryEntity>>> call() =>
      repository.getCategories();
}
