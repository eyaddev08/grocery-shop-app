import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/category.dart';
import '../repositories/category_repository.dart';

class GetCategories {
  GetCategories(this.repository);
  final CategoryRepository repository;

  Future<Either<Failure, List<Category>>> call() async => await repository.getCategories();
}
