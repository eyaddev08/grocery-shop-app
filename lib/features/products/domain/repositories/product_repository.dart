import '../../../../core/error/failure.dart';
import 'package:dartz/dartz.dart';
import '../entities/product_entity.dart';

abstract class ProductRepository {
  Future<Either<Failure, List<ProductEntity>>> getProducts();
}
