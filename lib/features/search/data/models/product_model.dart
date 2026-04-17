import 'dart:convert';
import '../../../../features/products/domain/entities/product_entity.dart';

class ProductModel extends ProductEntity {
  const ProductModel({
    required super.id,
    required super.name,
    super.thumbnail,
    super.images = const [],
    required super.price,
    super.originalPrice,
    super.discount,
    super.rating = 0.0,
    super.reviewCount = 0,
    super.categoryIds = const [],
    super.brand,
    super.shortDescription,
    super.status = 1,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json, {String? baseUrl}) {
    String? sanitizeUrl(dynamic raw) {
      if (raw == null) return null;
      final String s = raw.toString().trim();
      if (s.isEmpty || s.toLowerCase() == 'null') return null;
      if (s.startsWith('http://') || s.startsWith('https://')) return s;
      if (s.startsWith('/')) {
         return baseUrl != null ? Uri.parse(baseUrl).resolve(s).toString() : s;
      }
      return baseUrl != null ? '$baseUrl/$s' : s;
    }

    final id = (json['id'] ?? '').toString();
    final name = (json['name'] ?? '').toString();

    List<String> images = [];
    final rawImages = json['images'];
    if (rawImages is List) {
      images = rawImages.map(sanitizeUrl).whereType<String>().toList();
    } else if (rawImages is String) {
      try {
        final decoded = jsonDecode(rawImages);
        if (decoded is List) {
          images = decoded.map(sanitizeUrl).whereType<String>().toList();
        }
      } catch (_) {}
    }

    String? thumbnail = sanitizeUrl(json['thumbnail_full_url'] ?? json['thumbnail']);
    if (thumbnail == null && images.isNotEmpty) {
      thumbnail = images.first;
    }

    double parseDouble(dynamic v) {
      if (v == null) return 0.0;
      if (v is num) return v.toDouble();
      return double.tryParse(v.toString()) ?? 0.0;
    }
    
    int parseInt(dynamic v) {
      if (v == null) return 0;
      if (v is int) return v;
      return int.tryParse(v.toString()) ?? 0;
    }

    final List<int> categoryIds = [];
    final rawCats = json['category_ids'];
    if (rawCats is List) {
       for (var e in rawCats) {
         if (e is int) {
           categoryIds.add(e);
         } else if (e is String) {
           final p = int.tryParse(e);
           if (p != null) categoryIds.add(p);
         }
       }
    }

    return ProductModel(
      id: id,
      name: name,
      thumbnail: thumbnail,
      images: images,
      price: parseDouble(json['price']),
      originalPrice: json['original_price'] != null ? parseDouble(json['original_price']) : null,
      discount: json['discount'] != null ? parseDouble(json['discount']) : null,
      rating: parseDouble(json['rating']),
      reviewCount: parseInt(json['review_count']),
      categoryIds: categoryIds,
      brand: json['brand']?.toString(),
      shortDescription: json['short_description']?.toString(),
      status: parseInt(json['status'] ?? 1),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'thumbnail_full_url': thumbnail,
    'images': images,
    'price': price,
    'original_price': originalPrice,
    'discount': discount,
    'rating': rating,
    'review_count': reviewCount,
    'category_ids': categoryIds,
    'brand': brand,
    'short_description': shortDescription,
    'status': status,
  };

  ProductEntity toEntity() => ProductEntity(
      id: id,
      name: name,
      thumbnail: thumbnail,
      images: images,
      price: price,
      originalPrice: originalPrice,
      discount: discount,
      rating: rating,
      reviewCount: reviewCount,
      categoryIds: categoryIds,
      brand: brand,
      shortDescription: shortDescription,
      status: status,
    );
}
