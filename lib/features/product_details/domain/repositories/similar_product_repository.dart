import '../../../../core/error/failure.dart';
import 'package:dartz/dartz.dart';
import '../../../products/domain/entities/product_entity.dart';

abstract class SimilarProductRepository {
  Future<Either<Failure, List<ProductEntity>>> getSimilarProducts(String id, {int limit});
}

