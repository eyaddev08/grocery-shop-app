import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';

import '../../domain/repositories/product_details_repository.dart';
import '../../../products/domain/repositories/product_repository.dart';
import '../../../products/domain/entities/product_entity.dart';

class ProductDetailsRepositoryImpl implements ProductDetailsRepository {
  ProductDetailsRepositoryImpl(this.productRepository);
  final ProductRepository productRepository;

  @override
  Future<Either<Failure, ProductEntity>> getProductDetails(String id) async =>
      await productRepository.getProductById(id);
}
