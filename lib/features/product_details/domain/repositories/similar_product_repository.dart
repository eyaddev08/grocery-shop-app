import '../../../../core/error/failure.dart';
import 'package:dartz/dartz.dart';
import '../entities/similar_product.dart';

abstract class SimilarProductRepository {
    Future<Either<Failure, List<SimilarProduct>>> getSimilarProduct(String id);

}