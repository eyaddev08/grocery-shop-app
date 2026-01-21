import 'dart:convert';

import '../../domain/entities/search_result.dart';
import '../../../products/data/models/product_model.dart';
import '../../../products/domain/entities/product_entity.dart';

class SearchResultModel extends SearchResult {
  const SearchResultModel({
    required super.products,
    required super.total,
    required super.limit,
    super.cursor,
    super.nextCursor,
    super.facets,
  });

  factory SearchResultModel.fromJson(Map<String, dynamic> json) => SearchResultModel(
      products: _parseProducts(json['products']),
      total:
          _parseInt(json['total']) ?? _parseInt(json['products']?.length) ?? 0,
      limit: _parseInt(json['limit']) ?? _parseInt(json['per_page']) ?? 20,
      cursor: json['cursor']?.toString(),
      nextCursor: json['next_cursor']?.toString(),
      facets: _parseFacets(json['facets']),
    );

  factory SearchResultModel.fromDomain(SearchResult domain) => SearchResultModel(
      products: domain.products,
      total: domain.total,
      limit: domain.limit,
      cursor: domain.cursor,
      nextCursor: domain.nextCursor,
      facets: domain.facets,
    );

  Map<String, dynamic> toJson() => {
      'products': products.map(_productEntityToMap).toList(),
      'total': total,
      'limit': limit,
      'cursor': cursor,
      'next_cursor': nextCursor,
      'facets': _facetsToMap(facets),
    };

  static List<ProductEntity> _parseProducts(dynamic rawProducts) {
    if (rawProducts == null) return [];

    List<dynamic> productList = [];
    if (rawProducts is Iterable) {
      productList = List<dynamic>.from(rawProducts);
    } else if (rawProducts is String) {
      try {
        final decoded = jsonDecode(rawProducts);
        if (decoded is Iterable) productList = List<dynamic>.from(decoded);
      } catch (_) {}
    }

    return productList
        .map((item) {
          try {
            if (item is Map<String, dynamic>) {
              return ProductModel.fromJson(item).toEntity();
            } else if (item is Map) {
              return ProductModel.fromJson(Map<String, dynamic>.from(item))
                  .toEntity();
            }
          } catch (_) {}
          return null;
        })
        .whereType<ProductEntity>()
        .toList();
  }

  static int? _parseInt(dynamic value) {
    if (value is int) return value;
    if (value == null) return null;
    return int.tryParse(value.toString());
  }

  static Facets _parseFacets(dynamic raw) {
    if (raw == null) return const Facets();
    if (raw is Facets) return raw;
    if (raw is! Map) return const Facets();

    final Map<String, dynamic> m = Map<String, dynamic>.from(raw);

    return Facets(
      brands: _parseFacetItems(m['brands']),
      categories: _parseFacetItems(m['categories']),
      minPrice: _parseDouble(
          m['prices'] is Map ? m['prices']['min'] : m['price_min']),
      maxPrice: _parseDouble(
          m['prices'] is Map ? m['prices']['max'] : m['price_max']),
    );
  }

  static List<FacetItem> _parseFacetItems(dynamic rawItems) {
    if (rawItems is! Iterable) return [];
    return rawItems
        .map((item) {
          if (item is Map) {
            final id = (item['id'] ?? item['name'])?.toString() ?? '';
            final name = (item['name'] ?? item['id'])?.toString() ?? id;
            final count = _parseInt(item['count']) ?? 0;
            return FacetItem(id: id, name: name, count: count);
          }
          return null;
        })
        .whereType<FacetItem>()
        .toList();
  }

  static double? _parseDouble(dynamic value) {
    if (value is num) return value.toDouble();
    if (value == null) return null;
    return double.tryParse(value.toString());
  }

  static Map<String, dynamic> _facetsToMap(Facets f) => {
        'brands': f.brands
            .map((b) => {'id': b.id, 'name': b.name, 'count': b.count})
            .toList(),
        'categories': f.categories
            .map((c) => {'id': c.id, 'name': c.name, 'count': c.count})
            .toList(),
        'prices': {'min': f.minPrice, 'max': f.maxPrice},
      };

  Map<String, dynamic> _productEntityToMap(ProductEntity p) => {
      'id': p.id,
      'name': p.name,
      'slug': p.tag,
      'unit': p.unit,
      'price': p.price,
      'original_price': p.originalPrice,
      'discount': p.discount,
      'discount_type': p.discountType,
      'thumbnail': p.thumbnail,
      'images': p.images,
      'rating': p.rating,
      'review_count': p.reviewCount,
      'category_ids': p.categoryIds,
      'brand': p.brand,
      'short_description': p.shortDescription,
    };
}
