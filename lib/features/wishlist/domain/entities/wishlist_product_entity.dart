import 'package:equatable/equatable.dart';

import '../../../products/domain/entities/product_entity.dart';
import '../mappers/wishlist_product_entity_mapper.dart';

class WishlistProductEntity extends Equatable {
  const WishlistProductEntity({
    required this.id,
    required this.name,
    required this.price,
    required this.originalPrice,
    required this.unit,
    required this.subName,
    required this.tag,
    required this.slug,
    required this.thumbnail,
    required this.discount,
    required this.discountType,
    required this.isFavorite,
    required this.images,
    required this.nutritionLines,
    required this.rating,
    required this.reviewCount,
    required this.brand,
    required this.shippingCost,
    required this.currentStock,
    required this.categoryIds,
    required this.minOrderQty,
    required this.status,
  });
  final String id;
  final String name;
  final double price;
  final double? originalPrice;
  final String? unit;
  final String subName;
  final String? tag;
  final String? slug;
  final String thumbnail;
  final double? discount;
  final String? discountType;
  final bool isFavorite;
  final List<String> images;
  final Map<String, String> nutritionLines;
  final double rating;
  final int reviewCount;
  final String? brand;
  final double? shippingCost;
  final int currentStock;
  final List<int> categoryIds;
  final int minOrderQty;
  final int status;


  @override
  List<Object?> get props => [
        id,
        name,
        price,
        originalPrice,
        subName,
        tag,
        thumbnail,
        discount,
        isFavorite,
        images,
        nutritionLines,
        rating,
        reviewCount,
        currentStock,
        categoryIds,
        minOrderQty,
        status,
      ];
      ProductEntity toProductEntity() => WishlistProductEntityMapper.toProductEntity(this);

      
}
