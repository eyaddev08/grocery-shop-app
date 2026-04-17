import '../../../../core/error/failure.dart';
import 'package:dartz/dartz.dart';
import '../entities/product_entity.dart';
import '../repositories/product_repository.dart';

class GetRecommendedProductsUseCase {
  GetRecommendedProductsUseCase(this.repository);
  final ProductRepository repository;

  Future<Either<Failure, List<ProductEntity>>> call() async =>
      await repository.getRecommendedProducts();
}
