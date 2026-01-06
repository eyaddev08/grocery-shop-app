import '../../../../core/error/failure.dart';
import 'package:dartz/dartz.dart';
import '../entities/product_entity.dart';
import '../repositories/product_repository.dart';

class GetProducts {
  GetProducts(this.repository);
  final ProductRepository repository;

  Future<Either<Failure, List<ProductEntity>>> call() async => await repository.getProducts();
}
