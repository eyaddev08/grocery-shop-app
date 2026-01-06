import '../../../../core/error/failure.dart';
import 'package:dartz/dartz.dart';
import '../../../products/domain/entities/product_entity.dart';

abstract class SimilarProductRepository {
  /// Returns a list of similar products for [id], up to [limit].
  Future<Either<Failure, List<ProductEntity>>> getSimilarProducts(String id, {int limit});
}

