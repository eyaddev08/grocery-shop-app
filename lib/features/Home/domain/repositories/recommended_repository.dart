import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../entities/recommended_product.dart';

abstract class RecommendedRepository {
  Future<Either<Failure, List<RecommendedProduct>>> fetchRecommended();
}
