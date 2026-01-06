
import '../../../../core/error/failure.dart';
import 'package:dartz/dartz.dart';
import '../../../products/domain/entities/product_entity.dart';
import '../repositories/similar_product_repository.dart';

// class GetSimilarProduct {
//   GetSimilarProduct(this.repository);
//   final SimilarProductRepository repository;

//   Future<Either<Failure, List<ProductEntity>>> call(String id,  {int limit = 6}) async =>
//       await repository.getSimilarProduct(id);
// }

class GetSimilarProduct {
  GetSimilarProduct(this.repository);
  final SimilarProductRepository repository;

  Future<Either<Failure, List<ProductEntity>>> call(String id, {int limit = 6}) {
    return repository.getSimilarProducts(id, limit: limit);
  }
}