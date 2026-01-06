import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../../../products/domain/entities/product_entity.dart';

abstract class ProductDetailsRepository {
  Future<Either<Failure, ProductEntity>> getProductDetails(String id);

}
