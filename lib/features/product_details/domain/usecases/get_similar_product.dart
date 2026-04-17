import '../../../../core/error/failure.dart';
import 'package:dartz/dartz.dart';
import '../../../products/domain/entities/product_entity.dart';
import '../repositories/similar_product_repository.dart';

class GetSimilarProductUseCase {
  GetSimilarProductUseCase(this.repository);
  final SimilarProductRepository repository;

  Future<Either<Failure, List<ProductEntity>>> call(String id,
          {int limit = 6}) async =>
      await repository.getSimilarProducts(id, limit: limit);
}
