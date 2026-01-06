import 'package:dartz/dartz.dart';
import '../../../../core/constants/images_constants.dart';
import '../../../../core/error/failure.dart';
import '../../domain/entities/recommended_product.dart';
import '../../domain/repositories/recommended_repository.dart';

class RecommendedRepositoryImpl implements RecommendedRepository {
  final List<RecommendedProduct> _sample = const [
    RecommendedProduct(
        id: 'r1', title: 'Fresh Lemon', slug: 'Organic',  unit: 'Unit 12',
            price: 56,
     
      originalPrice: 66,
      discount: 10,
      discountType: 'percent',
      thumbnail: ImagesConstants.lemonPixabay,
      images: [
        ImagesConstants.lemonPixabay,
        ImagesConstants.lemonPixabay
      ],
      rating: 4.3,
      reviewCount: 32,
      inWishlist: true,
      currentStock: 5,
      shortDescription: 'Value bundle — 3 assorted fishes.',
      categoryIds: [1, 2],
      brand: 'ValuePack',
      minOrderQty: 1,
      shippingCost: 7,
      status: 1,
      nutritionLines: [],
        ),
    RecommendedProduct(
        id: 'r2', title: 'Green Tea', slug: 'Organic', unit: 'Unit 06',
            price: 65,
      originalPrice: 77,
      discount: 12,
      discountType: 'percent',
      thumbnail: ImagesConstants.vibrantGreenLeaves,
      images: [
        ImagesConstants.vibrantGreenLeaves,
        ImagesConstants.vibrantGreenLeaves
      ],
      rating: 4.1,
      reviewCount: 34,
      inWishlist: false,
      currentStock: 5,
      shortDescription: 'Value bundle — 3 assorted fishes.',
      categoryIds: [1, 2],
      brand: 'ValuePack',
      minOrderQty: 1,
      shippingCost: 7,
      status: 1,
      nutritionLines: [],
         ),
    RecommendedProduct(
        id: 'r3', title: 'Fresh Lime', slug: 'Organic', unit: 'Unit 11',
            price: 51,
      originalPrice: 40,
      discount: 11,
      discountType: 'percent',
      thumbnail: ImagesConstants.greenLime,
      images: [
        ImagesConstants.greenLime,
        ImagesConstants.greenLime
      ],
      rating: 4.6,
      reviewCount: 30,
      inWishlist: false,
      currentStock: 5,
      shortDescription: 'Value bundle — 3 assorted fishes.',
      categoryIds: [1, 2],
      brand: 'ValuePack',
      minOrderQty: 1,
      shippingCost: 7,
      status: 1,
      nutritionLines: [],
        ),
    RecommendedProduct(
        id: 'r4', title: 'Black Tea', slug: 'Organic', unit: 'Unit 05',
            price: 45,
      originalPrice: 50,
      discount: 5,
      discountType: 'percent',
      thumbnail: ImagesConstants.vibrantGreenLeaves,
      images: [
        ImagesConstants.vibrantGreenLeaves,
        ImagesConstants.vibrantGreenLeaves
      ],
      rating: 4.4,
      reviewCount: 29,
      inWishlist: true,
      currentStock: 5,
      shortDescription: 'Value bundle — 3 assorted fishes.',
      categoryIds: [1, 2],
      brand: 'ValuePack',
      minOrderQty: 1,
      shippingCost: 7,
      status: 1,
      nutritionLines: [],
        ),
  ];

  @override
  Future<Either<Failure, List<RecommendedProduct>>> fetchRecommended() async {
    await Future<void>.delayed(const Duration(milliseconds: 300));
    return Right(_sample);
  }
}
