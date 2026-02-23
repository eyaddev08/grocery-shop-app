import 'dart:convert';
import 'package:hive/hive.dart';
import '../../domain/entities/product_entity.dart';

part 'product_model.g.dart';

@HiveType(typeId: 1)
class ProductModel {
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
    this.images = const [],
    this.nutritionLines = const [],
    this.rating = 0.0,
    this.reviewCount = 0,
    this.inWishlist = false,
    this.currentStock = 0,
    this.shortDescription,
    this.categoryIds = const [],
    this.brand,
    this.minOrderQty = 1,
    this.shippingCost,
    this.status = 1,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    // Safe conversions to strings/nums
    final id = (json['id'] ?? '').toString();
    final name = (json['name'] ?? '').toString();
    // parse filterLabel — حاول مفاتيح مختلفة حسب API
    final filterLabel =
        (json['filter_label'] ?? json['filterLabel'])?.toString();

    final tag = json['tag']?.toString();
    final unit = json['unit']?.toString();

    // price parsing with fallbacks
    final price = parseDouble(
            json['unit_price'] ?? json['price'] ?? json['price_unit'], 0.0) ??
        0.0;

    // originalPrice and discount may legitimately be null, so pass fallback null
    final originalPrice = json.containsKey('purchase_price')
        ? parseDouble(json['purchase_price'], null)
        : null;
    final discount = json.containsKey('discount')
        ? parseDouble(json['discount'], null)
        : null;
    final discountType = json['discount_type']?.toString();

    // images: either list or JSON string
    final images = parseList<String>(json['images'], (e) => e.toString());

    final nutritionLines =
        parseList<String>(json['nutritionLines'], (e) => e.toString());

    // thumbnail: ensure we produce String? (never a raw dynamic)
    final dynamic rawThumb = json['thumbnail_full_url'] ??
        json['thumbnail'] ??
        (images.isNotEmpty ? images.first : null);
    final String? thumbnail = rawThumb?.toString();

    final rating = parseDouble(
            (json['rating'] is Map)
                ? (json['rating']['average'] ?? 0)
                : json['rating_average'] ?? json['rating'] ?? 0.0,
            0.0) ??
        0.0;
    final reviewCount = parseInt(
        json['reviews_count'] ?? json['review_count'] ?? json['reviews'] ?? 0);
    final inWishlist =
        (json['wish_list_count'] ?? json['in_wishlist'] ?? 0) != 0;

    final currentStock = parseInt(json['current_stock'] ?? json['stock'] ?? 0);

    // shortDescription as String?
    final dynamic rawShort =
        json['short_description'] ?? json['details'] ?? json['description'];
    final String? shortDescription = rawShort?.toString();

    // categories: sometimes array of objects, sometimes array of ids, sometimes JSON string
    final List<int> categoryIds = [];
    final rawCat = json['category_ids'] ??
        json['categories'] ??
        json['category_ids_formatted'];
    if (rawCat != null) {
      if (rawCat is List) {
        for (final e in rawCat) {
          if (e is int) {
            categoryIds.add(e);
          } else {
            final parsed = int.tryParse(e.toString());
            if (parsed != null) categoryIds.add(parsed);
          }
        }
      } else {
        try {
          final decoded = jsonDecode(rawCat.toString());
          if (decoded is List) {
            for (final e in decoded) {
              final parsed = int.tryParse(e.toString());
              if (parsed != null) categoryIds.add(parsed);
            }
          }
        } catch (_) {}
      }
    }

    final String? brand;
    if (json['brand'] is Map) {
      brand = (json['brand']['name'] ?? json['brand']['title'])?.toString();
    } else {
      brand = json['brand']?.toString();
    }
    final minOrderQty =
        parseInt(json['minimum_order_qty'] ?? json['min_order_qty'] ?? 1, 1);
    final shippingCost = json['shipping_cost'] != null
        ? parseDouble(json['shipping_cost'], null)
        : null;
    final status = parseInt(json['status'] ?? 1, 1);

    return ProductModel(
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
    );
  }

  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String? filterLabel;
  @HiveField(3)
  final String? tag;
  @HiveField(4)
  final String? unit;
  @HiveField(5)
  final double price;
  @HiveField(6)
  final double? originalPrice;
  @HiveField(7)
  final double? discount;
  @HiveField(8)
  final String? discountType;
  @HiveField(9)
  final String? thumbnail;
  @HiveField(10)
  final List<String> images;
  @HiveField(11)
  final List<String> nutritionLines;
  @HiveField(12)
  final double rating;
  @HiveField(13)
  final int reviewCount;
  @HiveField(14)
  final bool inWishlist;
  @HiveField(15)
  final int currentStock;
  @HiveField(16)
  final String? shortDescription;
  @HiveField(17)
  final List<int> categoryIds;
  @HiveField(18)
  final String? brand;
  @HiveField(19)
  final int minOrderQty;
  @HiveField(20)
  final double? shippingCost;
  @HiveField(21)
  final int status;

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'filterLabel': filterLabel,
        'tag': tag,
        'unit': unit,
        'price': price,
        'original_price': originalPrice,
        'discount': discount,
        'discount_type': discountType,
        'thumbnail': thumbnail,
        'images': images,
        'nutritionLines': nutritionLines,
        'rating': rating,
        'review_count': reviewCount,
        'wish_list_count': inWishlist ? 1 : 0,
        'current_stock': currentStock,
        'short_description': shortDescription,
        'category_ids': categoryIds,
        'brand': brand,
        'minimum_order_qty': minOrderQty,
        'shipping_cost': shippingCost,
        'status': status,
      };

  /// تحويل إلى Domain Entity (نستخدمها في الطبقات العليا)
  ProductEntity toEntity() => ProductEntity(
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
      );
}

int parseInt(dynamic v, [int fallback = 0]) {
  if (v == null) return fallback;
  if (v is int) return v;
  return int.tryParse(v.toString()) ?? fallback;
}

/// _parseDouble: if fallback is null, returns null on failure
double? parseDouble(dynamic v, [double? fallback = 0.0]) {
  if (v == null) return fallback;
  if (v is double) return v;
  if (v is int) return v.toDouble();
  return double.tryParse(v.toString()) ?? fallback;
}

List<T> parseList<T>(dynamic v, T Function(dynamic) itemMapper) {
  if (v == null) return <T>[];
  if (v is List) return v.map(itemMapper).toList();
  // sometimes APIs return JSON-string encoded lists
  try {
    final decoded = json.decode(v.toString());
    if (decoded is List) return decoded.map(itemMapper).toList();
  } catch (_) {}
  return <T>[];
}

// helper
String? _sanitizeUrl(String? raw, {String? baseUrl}) {
  if (raw == null) return null;
  final s = raw.toString().trim();
  if (s.isEmpty) return null;
  if (s.toLowerCase() == 'null') return null;
  if (s.startsWith('http://') || s.startsWith('https://')) return s;
  if (baseUrl != null) {
    try {
      return Uri.parse(baseUrl).resolve(s).toString();
    } catch (_) {}
  }
  return null;
}
