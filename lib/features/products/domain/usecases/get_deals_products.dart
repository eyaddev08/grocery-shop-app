import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../products/domain/entities/product_entity.dart';
import '../../../products/domain/repositories/product_repository.dart';

class GetDealsProductsUseCase {
  GetDealsProductsUseCase(this.repository);
  final ProductRepository repository;

  Future<Either<Failure, List<ProductEntity>>> call() async =>
      await repository.getDealsProducts();
}