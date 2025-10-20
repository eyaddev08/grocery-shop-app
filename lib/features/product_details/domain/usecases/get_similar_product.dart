import 'package:grocery_shop_app/features/product_details/domain/entities/similar_product.dart';

import '../../../../core/error/failure.dart';
import 'package:dartz/dartz.dart';import '../repositories/similar_product_repository.dart';

class GetSimilarProduct {

  GetSimilarProduct(this.repository);
  final SimilarProductRepository repository;

  Future<Either<Failure, List<SimilarProduct>>> call(String id) async => await repository.getSimilarProduct(id);
}