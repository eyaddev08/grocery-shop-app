import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/deal_product.dart';
import '../repositories/deal_product_repository.dart';



class GetDealProductsUseCase {
GetDealProductsUseCase(this.repository);
final DealProductRepository repository;


 Future<Either<Failure, List<DealsProduct>>> call() async => await repository.fetchProducts();
}