import '../../../../core/error/failure.dart';
import 'package:dartz/dartz.dart';
import '../entities/product.dart';

abstract class ProductRepository {
  Future<Either<Failure, List<Product>>> getProducts();
}
