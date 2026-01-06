import 'dart:convert';
import 'product_model.dart';

class ProductsResponse {
  final int totalSize;
  final int limit;
  final int offset;
  final double? minPrice;
  final double? maxPrice;
  final List<ProductModel> products;

  ProductsResponse({
    required this.totalSize,
    required this.limit,
    required this.offset,
    this.minPrice,
    this.maxPrice,
    this.products = const [],
  });

 factory ProductsResponse.fromJson(Map<String, dynamic> json) {
  final totalSize = parseInt(json['total_size'] ?? json['totalSize'] ?? 0);
  final limit = parseInt(json['limit'] ?? 0);
  final offset = parseInt(json['offset'] ?? 0);
  final minPrice = json['min_price'] != null ? parseDouble(json['min_price'], null) : null;
  final maxPrice = json['max_price'] != null ? parseDouble(json['max_price'], null) : null;
  final products = <ProductModel>[];

  dynamic rawProducts = json['products'];

  // Helper: try to convert various dynamic shapes into Map<String,dynamic> if possible
  Map<String, dynamic>? toMap(dynamic value) {
    if (value == null) return null;
    // already correct type
    if (value is Map<String, dynamic>) return value;
    // generic Map (keys may be dynamic) -> convert
    if (value is Map) {
      try {
        return Map<String, dynamic>.from(value);
      } catch (_) {
        // fallthrough
      }
    }
    // maybe it's a JSON string representing an object
    if (value is String) {
      try {
        final decoded = jsonDecode(value);
        if (decoded is Map<String, dynamic>) return decoded;
        if (decoded is Map) return Map<String, dynamic>.from(decoded);
      } catch (_) {}
    }
    return null;
  }

  // If rawProducts is a JSON string representing an array, decode it
  if (rawProducts is String) {
    try {
      final decoded = jsonDecode(rawProducts);
      if (decoded is List) {
        rawProducts = decoded;
      } else if (decoded is Map) {
        // maybe it's an object that wraps product entries
        rawProducts = decoded;
      }
    } catch (_) {
      // leave rawProducts as-is; handled below
    }
  }

  if (rawProducts is List) {
    for (final p in rawProducts) {
      // try direct map conversion
      final map = toMap(p);
      if (map != null) {
        products.add(ProductModel.fromJson(map));
        continue;
      }

      // if p is some other serializable object (e.g., encoded JSON as string), try decoding
      try {
        if (p is String) {
          final decoded = jsonDecode(p);
          if (decoded is Map<String, dynamic>) {
            products.add(ProductModel.fromJson(decoded));
            continue;
          } else if (decoded is Map) {
            products.add(ProductModel.fromJson(Map<String, dynamic>.from(decoded)));
            continue;
          }
        }
      } catch (_) {}

      // As last resort, if p is already a ProductModel instance (unlikely) skip/handle accordingly
    }
  } else if (rawProducts is Map) {
    // sometimes backend returns an object where values are product objects
    for (final v in rawProducts.values) {
      final map = toMap(v);
      if (map != null) {
        products.add(ProductModel.fromJson(map));
      } else {
        // try decode if string
        if (v is String) {
          try {
            final decoded = jsonDecode(v);
            if (decoded is Map<String, dynamic>) {
              products.add(ProductModel.fromJson(decoded));
            } else if (decoded is Map) {
              products.add(ProductModel.fromJson(Map<String, dynamic>.from(decoded)));
            }
          } catch (_) {}
        }
      }
    }
  }

  return ProductsResponse(
    totalSize: totalSize,
    limit: limit,
    offset: offset,
    minPrice: minPrice,
    maxPrice: maxPrice,
    products: products,
  );
}

}
