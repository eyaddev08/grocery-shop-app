import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../entities/recommended_product.dart';
import '../repositories/recommended_repository.dart';

class GetRecommendedProducts {
  GetRecommendedProducts(this.repository);
  final RecommendedRepository repository;

  Future<Either<Failure, List<RecommendedProduct>>> call() async =>
      await repository.fetchRecommended();
}
