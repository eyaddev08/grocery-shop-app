import '../../../products/domain/entities/product_entity.dart';

class DealsProduct {
  const DealsProduct({
    required this.id,
    required this.title,
    required this.price,
    this.regularPrice,
    this.slug,
    this.unit,
    this.originalPrice,
    this.discount,
    this.discountType,
    this.thumbnail,
    required this.images,
    required this.nutritionLines,
    required this.rating,
    required this.reviewCount,
    required this.inWishlist,
    required this.currentStock,
    this.shortDescription,
    required this.categoryIds,
    this.brand,
    required this.minOrderQty,
    this.shippingCost,
    required this.status,
  });
  final String id;
  final String title;
  final double price;
  final double? regularPrice;
  final String? slug;
  final String? unit;
  final double? originalPrice; // optional old price to show discount badge
  final double? discount; // numeric discount (absolute or percent depending)
  final String? discountType; // 'amount' or 'percent' (optional)
  final String? thumbnail; // url
  final List<String> images; // urls
  final List<String> nutritionLines;
  final double rating; // average rating 0.0 - 5.0
  final int reviewCount;
  final bool inWishlist;
  final int currentStock;
  final String? shortDescription;
  final List<int> categoryIds;
  final String? brand;
  final int minOrderQty;
  final double? shippingCost;
  final int status;

  // in deals_product_model.dart
  ProductEntity toEntity() => ProductEntity(
        id: id.toString(),
        name: title,
        price: price,
        originalPrice: originalPrice,
        thumbnail: thumbnail,
        images: images,
        discount: discount,
        discountType: discountType,
        rating: rating,
        reviewCount: reviewCount,
        shortDescription: shortDescription,
        inWishlist: inWishlist,
        nutritionLines: nutritionLines,
        status: status,
        currentStock: currentStock,
        shippingCost: shippingCost,
        minOrderQty: minOrderQty,
        tag: slug,
        brand: brand,
        unit: unit,
        categoryIds: categoryIds,
      );
}
