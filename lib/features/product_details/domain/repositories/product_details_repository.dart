import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../entities/product_details.dart';

abstract class ProductDetailsRepository {
  Future<Either<Failure, ProductDetails>> getProductDetails(String id);

}
