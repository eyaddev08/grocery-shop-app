

import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/deal_product.dart';

abstract class DealProductRepository {
  Future<Either<Failure, List<DealsProduct>>> fetchProducts();
}