import '../../../../core/helpers/json_converter.dart';
import '../../domain/entities/product_entity.dart';
import '../models/product_model.dart';

class ProductMapper {
  static ProductModel fromJson(Map<String, dynamic> json) {
    final imagesList =
        JsonConverter.parseList<String>(json['images'], (e) => e.toString());

    return ProductModel(
      id: (json['id'] ?? '').toString(),
      name: (json['name'] ?? '').toString(),
      filterLabel: (json['filter_label'] ?? json['filterLabel'])?.toString(),
      tag: json['tag']?.toString(),
      unit: json['unit']?.toString(),
      price: JsonConverter.parseDouble(
          json['unit_price'] ?? json['price'] ?? json['price_unit']),
      originalPrice: JsonConverter.parseDouble(json['originalPrice'], null),
      discount: JsonConverter.parseDouble(json['discount'], null),
      discountType: json['discountType']?.toString(),
      images: imagesList,
      thumbnail: (json['thumbnail_full_url'] ??
              json['thumbnail'] ??
              (imagesList.isNotEmpty ? imagesList.first : null))
          ?.toString(),
      nutritionLines: JsonConverter.parseNutrition(
          json['nutritionalInfo'] ?? json['nutritionLines']),
      rating: JsonConverter.parseRating(json),
      reviewCount:
          JsonConverter.parseInt(json['reviewCount'] ?? json['reviews']),
      inWishlist: (json['inWishlist'] ?? json['in_wishlist'] ?? 0) != 0,
      currentStock:
          JsonConverter.parseInt(json['currentStock'] ?? json['stock']),
      shortDescription:
          (json['shortDescription'] ?? json['details'] ?? json['description'])
              ?.toString(),
      categoryIds: JsonConverter.parseCategoryIds(json['categoryIds']),
      brand: JsonConverter.parseBrand(json['brand']),
      minOrderQty: JsonConverter.parseInt(
          json['minOrderQty'] ?? json['min_order_qty'], 1),
      shippingCost: JsonConverter.parseDouble(json['shippingCost'], null),
      status: JsonConverter.parseInt(json['status'], 1),
      slug: json['slug']?.toString() ?? '',
    );
  }

  static ProductModel toModel(ProductEntity entity) => ProductModel(
        id: entity.id,
        name: entity.name,
        price: entity.price,
        originalPrice: entity.originalPrice,
        unit: entity.unit,
        filterLabel: entity.filterLabel,
        tag: entity.tag,
        slug: entity.slug,
        thumbnail: entity.thumbnail,
        discount: entity.discount,
        discountType: entity.discountType,
        images: entity.images,
        nutritionLines: entity.nutritionLines,
        rating: entity.rating,
        reviewCount: entity.reviewCount,
        currentStock: entity.currentStock,
        shortDescription: entity.shortDescription,
        categoryIds: entity.categoryIds,
        brand: entity.brand,
        minOrderQty: entity.minOrderQty,
        shippingCost: entity.shippingCost,
        inWishlist: entity.inWishlist,
        status: entity.status,
      );

  static ProductEntity toEntity(ProductModel model) => ProductEntity(
        id: model.id,
        name: model.name,
        price: model.price,
        originalPrice: model.originalPrice,
        unit: model.unit,
        filterLabel: model.filterLabel,
        tag: model.tag,
        slug: model.slug,
        thumbnail: model.thumbnail,
        discount: model.discount,
        discountType: model.discountType,
        images: model.images,
        nutritionLines: model.nutritionLines,
        rating: model.rating,
        reviewCount: model.reviewCount,
        currentStock: model.currentStock,
        shortDescription: model.shortDescription,
        categoryIds: model.categoryIds,
        brand: model.brand,
        minOrderQty: model.minOrderQty,
        shippingCost: model.shippingCost,
        inWishlist: model.inWishlist,
        status: model.status,
      );

  static Map<String, dynamic> toJson(ProductModel model) => {
        'id': model.id,
        'name': model.name,
        'price': model.price,
        'originalPrice': model.originalPrice,
        'unit': model.unit,
        'filterLabel': model.filterLabel,
        'tag': model.tag,
        'slug': model.slug,
        'thumbnail': model.thumbnail,
        'discount': model.discount,
        'discountType': model.discountType,
        'images': model.images,
        'nutritionLines': model.nutritionLines,
        'rating': model.rating,
        'reviewCount': model.reviewCount,
        'currentStock': model.currentStock,
        'shortDescription': model.shortDescription,
        'categoryIds': model.categoryIds,
        'brand': model.brand,
        'minOrderQty': model.minOrderQty,
        'shippingCost': model.shippingCost,
        'inWishlist': model.inWishlist,
        'status': model.status,
      };
}
