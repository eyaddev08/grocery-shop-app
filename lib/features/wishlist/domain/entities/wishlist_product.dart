// class WishlistProduct {

//   const WishlistProduct({
//     required this.id,
//     required this.title,
//     required this.price,
//     this.oldPrice,
//     required this.subTitle,
//     required this.imageUrl,
//     this.discount,
//     this.isFavorite = true,
//   });
//   final String id;
//   final String title;
//   final double price;
//   final double? oldPrice;
//   final String subTitle;
//   final String imageUrl;
//   final int? discount;
//   final bool isFavorite;

//   WishlistProduct copyWith({
//     String? id,
//     String? title,
//     double? price,
//     double? oldPrice,

//     String? subTitle,
//     String? color,
//     String? imageUrl,
//     int? discount,
//     bool? isFavorite,
//   }) => WishlistProduct(
//       id: id ?? this.id,
//       title: title ?? this.title,
//       price: price ?? this.price,
//       oldPrice: oldPrice ?? this.oldPrice,
//       subTitle: subTitle ?? this.subTitle,
//       imageUrl: imageUrl ?? this.imageUrl,
//       discount: discount ?? this.discount,
//       isFavorite: isFavorite ?? this.isFavorite,
//     );
// }

import '../../../products/domain/entities/product_entity.dart';

class WishlistProduct {
  const WishlistProduct({
    required this.id,
    required this.title,
    required this.price,
    this.oldPrice,
    required this.subTitle,
    this.thumbnail,
    this.tag,
    this.discount,
    this.isFavorite = true,
    this.regularPrice,
    this.slug,
    this.unit,
    this.discountType,
    required this.images,
    required this.nutritionLines,
    required this.rating,
    required this.reviewCount,
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
  final double? oldPrice;
  final String subTitle;
  final double? discount;
  final bool isFavorite;
  final String? tag;
  final String? thumbnail;
  final double? regularPrice;
  final String? slug;
  final String? unit;
  final String? discountType;
  final List<String> images;
  final List<String> nutritionLines;
  final double rating; // average rating 0.0 - 5.0
  final int reviewCount;
  final int currentStock;
  final String? shortDescription;
  final List<int> categoryIds;
  final String? brand;
  final int minOrderQty;
  final double? shippingCost;
  final int status;

  WishlistProduct copyWith({
    String? id,
    String? title,
    double? price,
    double? oldPrice,
    String? subTitle,
    String? color,
    String? thumbnail,
    double? discount,
    bool? isFavorite,
    String? tag,
    double? regularPrice,
    String? slug,
    String? unit,
    String? discountType,
    List<String>? images,
    List<String>? nutritionLines,
    double? rating,
    int? reviewCount,
    int? currentStock,
    String? shortDescription,
    List<int>? categoryIds,
    String? brand,
    int? minOrderQty,
    double? shippingCost,
    int? status,
  }) =>
      WishlistProduct(
        id: id ?? this.id,
        title: title ?? this.title,
        price: price ?? this.price,
        oldPrice: oldPrice ?? this.oldPrice,
        subTitle: subTitle ?? this.subTitle,
        thumbnail: thumbnail ?? this.thumbnail,
        discount: discount ?? this.discount,
        isFavorite: isFavorite ?? this.isFavorite,
        images: images ?? this.images,
        discountType: discountType ?? this.discountType,
        rating: rating ?? this.rating,
        reviewCount: reviewCount ?? this.reviewCount,
        shortDescription: shortDescription ?? this.shortDescription,
        nutritionLines: nutritionLines ?? this.nutritionLines,
        status: status ?? this.status,
        shippingCost: shippingCost ?? this.shippingCost,
        minOrderQty: minOrderQty ?? this.minOrderQty,
        tag: tag ?? this.tag,
        brand: brand ?? this.brand,
        slug: slug ?? this.slug,
        unit: unit ?? this.unit,
        categoryIds: categoryIds ?? this.categoryIds,
        currentStock: currentStock ?? this.currentStock,
      );

  ProductEntity toEntity() => ProductEntity(
        id: id.toString(),
        name: title,
        price: price,
        originalPrice: oldPrice,
        thumbnail: thumbnail,
        images: images,
        discount: discount,
        discountType: discountType,
        rating: rating,
        reviewCount: reviewCount,
        shortDescription: shortDescription,
        inWishlist: isFavorite,
        nutritionLines: nutritionLines,
        status: status,
        shippingCost: shippingCost,
        minOrderQty: minOrderQty,
        tag: tag,
        brand: brand,
        currentStock: currentStock,
        unit: unit,
        categoryIds: categoryIds,
      );
}
