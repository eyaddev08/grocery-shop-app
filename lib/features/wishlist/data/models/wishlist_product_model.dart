import 'package:hive/hive.dart';
import '../../domain/entities/wishlist_product_entity.dart';
import '../mappers/wishlist_product_mapper.dart'; 

part 'wishlist_product_model.g.dart';

@HiveType(typeId: 4)
class WishlistProductModel extends WishlistProductEntity {
  @override @HiveField(0) final String id;
  @override @HiveField(1) final String name;
  @override @HiveField(2) final double price;
  @override @HiveField(3) final double? originalPrice;
  @HiveField(4) final String? unit;
  @override @HiveField(5) final String subName;
  @override @HiveField(6) final String? tag;
  @HiveField(7) final String? slug;
  @override @HiveField(8) final String thumbnail;
  @override @HiveField(9) final double? discount;
  @HiveField(10) final String? discountType;
  @override @HiveField(11) final bool isFavorite;
  @override @HiveField(12) final List<String> images;
  @override @HiveField(13) final Map<String, String> nutritionLines;
  @override @HiveField(14) final double rating;
  @override @HiveField(15) final int reviewCount;
  @HiveField(16) final String? brand;
  @HiveField(17) final double? shippingCost;
  @override @HiveField(18) final int currentStock;
  @override @HiveField(19) final List<int> categoryIds;
  @override @HiveField(20) final int minOrderQty;
  @override @HiveField(21) final int status;

  const WishlistProductModel({
    required this.id,
    required this.name,
    required this.price,
    this.originalPrice,
    this.unit,
    required this.subName,
    this.tag,
    this.slug,
    required this.thumbnail,
    this.discount,
    this.discountType,
    required this.isFavorite,
    required this.images,
    required this.nutritionLines,
    required this.rating,
    required this.reviewCount,
    this.brand,
    this.shippingCost,
    required this.currentStock,
    required this.categoryIds,
    required this.minOrderQty,
    required this.status,
  }) : super(
          id: id, name: name, price: price, originalPrice: originalPrice,
          unit: unit, subName: subName, tag: tag, slug: slug,
          thumbnail: thumbnail, discount: discount, discountType: discountType,
          isFavorite: isFavorite, images: images, nutritionLines: nutritionLines,
          rating: rating, reviewCount: reviewCount, brand: brand,
          shippingCost: shippingCost, currentStock: currentStock,
          categoryIds: categoryIds, minOrderQty: minOrderQty, status: status,
        );

  factory WishlistProductModel.fromJson(Map<String, dynamic> json) => 
      WishlistProductMapper.fromJson(json);

  Map<String, dynamic> toJson() => WishlistProductMapper.toJson(this);

  WishlistProductEntity toEntity() => WishlistProductMapper.toEntity(this);

  WishlistProductModel toModel() => WishlistProductMapper.toModel(this);

  WishlistProductModel copyWith({
    String? id,
    String? name,
    double? price,
    double? originalPrice,
    String? unit,
    String? subName,
    String? tag,
    String? slug,
    String? thumbnail,
    double? discount,
    String? discountType,
    bool? isFavorite,
    List<String>? images,
    Map<String, String>? nutritionLines,
    double? rating,
    int? reviewCount,
    String? brand,
    double? shippingCost,
    int? currentStock,
    List<int>? categoryIds,
    int? minOrderQty,
    int? status,
  }) =>
      WishlistProductModel(
        id: id ?? this.id,
        name: name ?? this.name,
        price: price ?? this.price,
        originalPrice: originalPrice ?? this.originalPrice,
        unit: unit ?? this.unit,
        subName: subName ?? this.subName,
        tag: tag ?? this.tag,
        slug: slug ?? this.slug,
        thumbnail: thumbnail ?? this.thumbnail,
        isFavorite: isFavorite ?? this.isFavorite,
        images: images ?? this.images,
        nutritionLines: nutritionLines ?? this.nutritionLines,
        discount: discount ?? this.discount,
        discountType: discountType ?? this.discountType,
        rating: rating ?? this.rating,
        reviewCount: reviewCount ?? this.reviewCount,
        brand: brand ?? this.brand,
        shippingCost: shippingCost ?? this.shippingCost,
        currentStock: currentStock ?? this.currentStock,
        categoryIds: categoryIds ?? this.categoryIds,
        minOrderQty: minOrderQty ?? this.minOrderQty,
        status: status ?? this.status,
      );
}