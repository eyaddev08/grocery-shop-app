import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../../domain/entities/product_details.dart';
import '../../domain/entities/similar_product.dart';
import '../../domain/repositories/product_details_repository.dart';

class ProductDetailsRepositoryImpl implements ProductDetailsRepository {
  @override
  Future<Either<Failure, ProductDetails>> getProductDetails(String id) async {
    try {
      await Future<void>.delayed(const Duration(milliseconds: 1500));

      final details = ProductDetails(
        id: id,
        title: 'Fresh Apples',
        description:
            'Crisp, sweet and juicy apples. Perfect for snacks and baking.',
        price: 3.49,
        regularPrice: 4.99,
        image: [
          'assets/svg/empty_image.svg',
          'assets/svg/empty_image.svg',
          'assets/svg/empty_image.svg',
        ],
        nutritionLines: ['Calories 95', 'Fat 0g', 'Carbs 25g', 'Protein 0g'],
        reviewCount: 128,
      );

      return Right(details);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, SimilarProduct>> getSimilarProduct(String id) async {
    try {
      await Future<void>.delayed(const Duration(milliseconds: 1500));

      final similar = SimilarProduct(
        id: id,
        title: 'Fresh Apples',
        price: '3.49',
        image: 'assets/svg/empty_image.svg',
      );

      return Right(similar);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
