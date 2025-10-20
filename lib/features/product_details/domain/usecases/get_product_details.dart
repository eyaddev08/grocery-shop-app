import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../entities/product_details.dart';
import '../repositories/product_details_repository.dart';

class GetProductDetails {
  final ProductDetailsRepository repository;

  GetProductDetails(this.repository);

  Future<Either<Failure, ProductDetails>> call(String id) async {
    return await repository.getProductDetails(id);
  }
}
