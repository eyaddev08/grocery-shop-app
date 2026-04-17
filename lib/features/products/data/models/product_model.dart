import 'package:hive/hive.dart';
import '../../domain/entities/product_entity.dart';
import '../mappers/product_mapper.dart';

part 'product_model.g.dart';

@HiveType(typeId: 1)
class ProductModel extends ProductEntity {
  @override @HiveField(0)
  final String id;
  @override @HiveField(1)
  final String name;
  @override @HiveField(2)
  final String? filterLabel;
  @override @HiveField(3)
  final String? tag;
  @override @HiveField(4)
  final String? unit;
  @override @HiveField(5)
  final double price;
  @override @HiveField(6)
  final double? originalPrice;
  @override @HiveField(7)
  final double? discount;
  @override @HiveField(8)
  final String? discountType;
  @override @HiveField(9)
  final String? thumbnail;
  @override @HiveField(10)
  final List<String> images;
  @override @HiveField(11)
  final Map<String, String> nutritionLines;
  @override @HiveField(12)
  final double rating;
  @override @HiveField(13)
  final int reviewCount;
  @override @HiveField(14)
  final bool inWishlist;
  @override @HiveField(15)
  final int currentStock;
  @override @HiveField(16)
  final String? shortDescription;
  @override @HiveField(17)
  final List<int> categoryIds;
  @override @HiveField(18)
  final String? brand;
  @override @HiveField(19)
  final int minOrderQty;
  @override @HiveField(20)
  final double? shippingCost;
  @override @HiveField(21)
  final int status;
  @override @HiveField(22)
  final String slug;

  const ProductModel({
    required this.id,
    required this.name,
    this.filterLabel,
    this.tag,
    this.unit,
    required this.price,
    this.originalPrice,
    this.discount,
    this.discountType,
    this.thumbnail,
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
    required this.inWishlist,
    required this.slug,
  }) : super(
          id: id,
          name: name,
          filterLabel: filterLabel,
          tag: tag,
          unit: unit,
          price: price,
          originalPrice: originalPrice,
          discount: discount,
          discountType: discountType,
          thumbnail: thumbnail,
          images: images,
          nutritionLines: nutritionLines,
          rating: rating,
          reviewCount: reviewCount,
          inWishlist: inWishlist,
          currentStock: currentStock,
          shortDescription: shortDescription,
          categoryIds: categoryIds,
          brand: brand,
          minOrderQty: minOrderQty,
          shippingCost: shippingCost,
          status: status,
          slug: slug,
        );

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      ProductMapper.fromJson(json);

  ProductModel toModel() => ProductMapper.toModel(this);

  Map<String, dynamic> toJson() => ProductMapper.toJson(this);

  ProductEntity toEntity() => ProductMapper.toEntity(this);

}
