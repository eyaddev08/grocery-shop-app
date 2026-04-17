import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../../../products/domain/entities/product_entity.dart';
import '../repositories/product_details_repository.dart';

class GetProductDetailsUseCase {
  GetProductDetailsUseCase(this.repository);
  final ProductDetailsRepository repository;

  Future<Either<Failure, ProductEntity>> call(String id) async =>
      await repository.getProductDetails(id);
}
