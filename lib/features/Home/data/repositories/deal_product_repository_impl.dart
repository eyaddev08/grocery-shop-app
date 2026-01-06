import 'dart:async';
import 'package:dartz/dartz.dart';

import '../../../../core/constants/images_constants.dart';
import '../../../../core/error/failure.dart';
import '../../domain/entities/deal_product.dart';
import '../../domain/repositories/deal_product_repository.dart';

class DealProductRepositoryImpl implements DealProductRepository {
  final List<DealsProduct> _sample = [
    const DealsProduct(
      id: 'p1',
      title: 'Orange Package 1 | 1 bundle',
      price: 325,
      regularPrice: 350,
      slug: 'bundle-3',
      unit: 'bundle',
      originalPrice: 240,
      discount: 17,
      discountType: 'percent',
      thumbnail: ImagesConstants.orangePixabay,
      images: [ImagesConstants.orangePixabay, ImagesConstants.orangePixabay],
      rating: 4.4,
      reviewCount: 33,
      inWishlist: false,
      currentStock: 5,
      shortDescription: 'Value bundle — 3 assorted items.',
      categoryIds: [1, 2],
      brand: 'ValuePack',
      minOrderQty: 1,
      shippingCost: 7,
      status: 1,
      nutritionLines: [],
    ),
    const DealsProduct(
      id: 'p2',
      title: 'Green Tea Package 2 | 1 bundle',
      price: 89,
      slug: 'bundle-3',
      unit: 'bundle',
      originalPrice: 240,
      discount: 17,
      discountType: 'percent',
      thumbnail: ImagesConstants.vibrantGreenLeaves,
      images: [ImagesConstants.vibrantGreenLeaves, ImagesConstants.vibrantGreenLeaves],
      rating: 4.3,
      reviewCount: 32,
      inWishlist: true,
      currentStock: 5,
      shortDescription: 'Value bundle — green tea pack.',
      categoryIds: [1, 2],
      brand: 'ValuePack',
      minOrderQty: 1,
      shippingCost: 7,
      status: 1,
      nutritionLines: [],
    ),
    const DealsProduct(
      id: 'p8',
      title: 'Apple Pack | 3 kg',
      price: 120,
      slug: 'bundle-3',
      unit: 'bundle',
      originalPrice: 240,
      discount: 17,
      discountType: 'percent',
      thumbnail: ImagesConstants.applePixabay,
      images: [ImagesConstants.applePixabay, ImagesConstants.applePixabay],
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
    const DealsProduct(
      id: 'p4',
      title: 'Black Tea | 1 pack',
      price: 45,
      regularPrice: 55,
      slug: 'bundle-3',
      unit: 'bundle',
      originalPrice: 240,
      discount: 17,
      discountType: 'percent',
      thumbnail: ImagesConstants.vibrantGreenLeaves,
      images: [
        ImagesConstants.vibrantGreenLeaves,
        ImagesConstants.vibrantGreenLeaves
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
  ];
  @override
  Future<Either<Failure, List<DealsProduct>>> fetchProducts() async {
    await Future<void>.delayed(const Duration(milliseconds: 1000));
    return Right(_sample);
  }
}
