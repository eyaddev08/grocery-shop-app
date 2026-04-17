import 'dart:convert';

class JsonConverter {
  static double parseDouble(dynamic v, [double? fallback = 0.0]) {
    if (v == null) return fallback ?? 0.0;
    return double.tryParse(v.toString()) ?? (fallback ?? 0.0);
  }

  static int parseInt(dynamic v, [int fallback = 0]) {
    if (v == null) return fallback;
    return int.tryParse(v.toString()) ?? fallback;
  }

  static List<T> parseList<T>(dynamic v, T Function(dynamic) itemMapper) {
    if (v == null) return <T>[];
    if (v is List) return v.map(itemMapper).toList();
    try {
      final decoded = jsonDecode(v.toString());
      if (decoded is List) return decoded.map(itemMapper).toList();
    } catch (_) {}
    return <T>[];
  }

  static Map<String, String> parseNutrition(dynamic v) {
    if (v == null) return {};
    if (v is Map) return v.map((key, value) => MapEntry(key.toString(), value.toString()));
    return {};
  }

  static List<int> parseCategoryIds(dynamic rawCat) {
    if (rawCat == null) return [];
    final List<dynamic> list = (rawCat is String) ? (jsonDecode(rawCat) as List) : (rawCat as List);
    return list.map((e) => int.tryParse(e.toString()) ?? 0).where((e) => e != 0).toList();
  }

  static String? parseBrand(dynamic brand) {
    if (brand is Map) return (brand['name'] ?? brand['title'])?.toString();
    return brand?.toString();
  }

  static double parseRating(Map<String, dynamic> json) {
    final rawRating = (json['rating'] is Map) 
        ? (json['rating']['average'] ?? 0) 
        : (json['rating_average'] ?? json['rating'] ?? 0.0);
    return parseDouble(rawRating);
  }
    static Map<String, String> parseStringMap(dynamic value) {
    if (value is Map) {
      return value.map((k, v) => MapEntry(k.toString(), v.toString()));
    }
    return {};
  }
}

