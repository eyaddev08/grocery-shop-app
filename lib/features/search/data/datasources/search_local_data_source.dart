import 'package:hive/hive.dart';

import '../../../products/domain/entities/product_entity.dart';
import '../../domain/entities/search_result.dart';
import '../models/suggestion_model.dart';
import '../models/search_result_model.dart';

abstract class SearchLocalDataSource {
  Future<void> cacheSuggestions(List<SuggestionModel> suggestions);

  Future<List<SuggestionModel>> getCachedSuggestions();

  Future<void> cacheLastResult(SearchResultModel result);

  Future<SearchResultModel?> getLastResult();

  Future<void> addSearchToHistory(String query);

  Future<List<String>> getSearchHistory();

  Future<void> clearSearchHistory();

  Future<void> removeSearchHistoryItem(String query);

 Future<SearchResultModel> searchInList({
    required List<dynamic> products, 
    required String query,
    Map<String, dynamic>? filters,
    String? cursor,
    int limit = 20,
    String sort = 'relevance',
  });
}

class SearchLocalDataSourceImpl implements SearchLocalDataSource {
  final Box<dynamic> box;

  static const _kSuggestionsKey = 'search_suggestions';
  static const _kLastResultKey = 'search_last_result';
  static const _kHistoryKey = 'search_history';

  SearchLocalDataSourceImpl(this.box);

  @override
  Future<SearchResultModel> searchInList({
    required List<dynamic> products,
    required String query,
    Map<String, dynamic>? filters,
    String? cursor,
    int limit = 20,
    String sort = 'relevance',
  }) async {
    final lowerQuery = query.toLowerCase().trim();

    // 1. Filter by Query
    List<dynamic> matched;
    if (lowerQuery.isEmpty) {
      matched = List.from(products);
    } else {
      matched = products.where((p) {

        final name = (p.name ?? '').toString().toLowerCase();
        final brand = (p.brand ?? '').toString().toLowerCase();
        final desc = (p.shortDescription ?? '').toString().toLowerCase();
        return name.contains(lowerQuery) ||
            brand.contains(lowerQuery) ||
            desc.contains(lowerQuery);
      }).toList();
    }

    // 2. Apply Filters
    if (filters != null && filters.isNotEmpty) {
      // Brand
      if (filters.containsKey('brand')) {
        final fb = filters['brand']?.toString().toLowerCase() ?? '';
        if (fb.isNotEmpty) {
          matched = matched
              .where((p) => (p.brand ?? '').toString().toLowerCase() == fb)
              .toList();
        }
      }

      // Category
      if (filters.containsKey('category_id')) {
        final raw = filters['category_id'];
        final int? cid = raw is int ? raw : int.tryParse(raw?.toString() ?? '');
        if (cid != null) {
          matched = matched.where((p) {
            final cats = p.categoryIds;
            if (cats is Iterable) {
              return cats.contains(cid);
            }
            return false;
          }).toList();
        }
      }

      // Price Range
      final minP = _parseDouble(filters['price_min']);
      final maxP = _parseDouble(filters['price_max']);

      if (minP != null)
        matched = matched.where((p) => _getPrice(p) >= minP).toList();
      if (maxP != null)
        matched = matched.where((p) => _getPrice(p) <= maxP).toList();
    }

    // 3. Sorting
    if (sort == 'price_asc') {
      matched.sort((a, b) => _getPrice(a).compareTo(_getPrice(b)));
    } else if (sort == 'price_desc') {
      matched.sort((a, b) => _getPrice(b).compareTo(_getPrice(a)));
    } else if (sort == 'rating') {
      matched.sort((a, b) => _getRating(b).compareTo(_getRating(a)));
    }

    // 4. Pagination
    final total = matched.length;
    final offset = int.tryParse(cursor ?? '0') ?? 0;

    final paged =
        (offset >= total) ? [] : matched.skip(offset).take(limit).toList();

    final nextOffset = offset + limit;
    final nextCursor = nextOffset >= total ? null : nextOffset.toString();

    // 5. Build Facets (Simple)
    final facets = _buildFacets(matched);

    return SearchResultModel(
      products: paged.map((e) => e).toList().cast<ProductEntity>(),
      total: total,
      limit: limit,
      cursor: cursor,
      nextCursor: nextCursor,
      facets: facets,
    );
  }

  double _getPrice(dynamic p) {
    if (p.price is num) return (p.price as num).toDouble();
    return 0.0;
  }

  double _getRating(dynamic p) {
    if (p.rating is num) return (p.rating as num).toDouble();
    return 0.0;
  }

  double? _parseDouble(dynamic v) {
    if (v is num) return v.toDouble();
    if (v == null) return null;
    return double.tryParse(v.toString());
  }

  Facets _buildFacets(List<dynamic> products) {
    if (products.isEmpty) return const Facets();

    final Map<String, int> brandCount = {};
    final Map<int, int> catCount = {};
    double? minP;
    double? maxP;

    for (final p in products) {
      final b = (p.brand ?? '').toString().trim();
      if (b.isNotEmpty) brandCount[b] = (brandCount[b] ?? 0) + 1;

      final cats = p.categoryIds;
      if (cats is Iterable) {
        for (final cid in cats) {
          if (cid is int) catCount[cid] = (catCount[cid] ?? 0) + 1;
        }
      }

      final double price = _getPrice(p);
      minP = (minP == null || price < minP) ? price : minP;
      maxP = (maxP == null || price > maxP) ? price : maxP;
    }

    final brands = brandCount.entries
        .map((e) => FacetItem(id: e.key, name: e.key, count: e.value))
        .toList();
    final categories = catCount.entries
        .map((e) => FacetItem(
            id: e.key.toString(), name: 'Category ${e.key}', count: e.value))
        .toList();

    return Facets(
        brands: brands, categories: categories, minPrice: minP, maxPrice: maxP);
  }

  // Helper: read raw value or default
  dynamic _getBoxValue(String key) => box.get(key);

  @override
  Future<void> cacheSuggestions(List<SuggestionModel> suggestions) async {
    try {
      final List<Map<String, dynamic>> list =
          suggestions.map((s) => s.toJson()).toList();
      await box.put(_kSuggestionsKey, list);
    } catch (_) {}
  }

  @override
  Future<List<SuggestionModel>> getCachedSuggestions() async {
    try {
      final raw = box.get(_kSuggestionsKey);
      if (raw is List) {
        return raw
            .map((e) {
              if (e is Map)
                return SuggestionModel.fromJson(Map<String, dynamic>.from(e));
              return null;
            })
            .whereType<SuggestionModel>()
            .toList();
      }
    } catch (_) {}
    return <SuggestionModel>[];
  }

  @override
  Future<void> cacheLastResult(SearchResultModel result) async {
    try {
      await box.put(_kLastResultKey, result.toJson());
    } catch (_) {}
  }

  @override
  Future<SearchResultModel?> getLastResult() async {
    try {
      final raw = box.get(_kLastResultKey);
      if (raw is Map) {
        return SearchResultModel.fromJson(Map<String, dynamic>.from(raw));
      }
    } catch (_) {}
    return null;
  }

  @override
  Future<void> addSearchToHistory(String query) async {
    try {
      final raw = box.get(_kHistoryKey);

      List<String> history = [];
      if (raw is List) {
        history = raw.map((e) => e.toString()).toList();
      }

      history.removeWhere((x) => x.toLowerCase() == query.toLowerCase());
      history.insert(0, query);
      if (history.length > 20) history = history.sublist(0, 20);

      await box.put(_kHistoryKey, history);

    } catch (e) {}
  }

  @override
  Future<List<String>> getSearchHistory() async {
    try {
      final raw = box.get(_kHistoryKey);
      if (raw is List) return raw.map((e) => e.toString()).toList();
    } catch (_) {}
    return <String>[];
  }

  @override
  Future<void> clearSearchHistory() async {
    try {
      await box.delete(_kHistoryKey);
    } catch (_) {}
  }

  @override
  Future<void> removeSearchHistoryItem(String query) async {
    try {
      final raw = box.get(_kHistoryKey);
      List<String> history = [];
      if (raw is List) {
        history = raw.map((e) => e.toString()).toList();
      }
      history.removeWhere((x) => x.toLowerCase() == query.toLowerCase());
      await box.put(_kHistoryKey, history);
    } catch (_) {}
  }
}
