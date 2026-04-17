import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../../../products/domain/entities/product_entity.dart';
import '../../../products/domain/repositories/product_repository.dart';
import '../entities/search_result.dart';
import '../repositories/search_repository.dart';

class SearchProductsParamsUseCase {
  SearchProductsParamsUseCase({
    required this.query,
    this.filters,
    this.cursor,
    this.limit = 20,
    this.sort = 'relevance',
  });
  final String query;
  final Map<String, dynamic>? filters;
  final String? cursor;
  final int limit;
  final String sort;
}

class SearchProducts {
  SearchProducts({
    required this.searchRepository,
    required this.productRepository,
  });

  final SearchRepository searchRepository;
  final ProductRepository productRepository;

  Future<Either<Failure, SearchResult>> call(SearchProductsParamsUseCase params) async {
    final remoteResult = await searchRepository.search(
      query: params.query,
      filters: params.filters,
      cursor: params.cursor,
      limit: params.limit,
      sort: params.sort,
    );

    return remoteResult.fold(
      (failure) async {
        final productsResult = await productRepository.getProducts();
        return productsResult.fold(
          (f) => Left(f),
          (products) async {
            final result = _filterLocalProducts(products, params);
            if (params.cursor == null && params.query.isNotEmpty) {
               await searchRepository.addSearchToHistory(params.query);
            }
            return Right(result);
          }
        );
      },
      (success) => Right(success),
    );
  }

  SearchResult _filterLocalProducts(List<ProductEntity> products, SearchProductsParamsUseCase params) {
    final lowerQuery = params.query.toLowerCase().trim();

    List<ProductEntity> matched;
    if (lowerQuery.isEmpty) {
      matched = List.from(products);
    } else {
      matched = products.where((p) {
        final name = p.name.toLowerCase();
        final brand = (p.brand ?? '').toLowerCase();
        final desc = (p.shortDescription ?? '').toLowerCase();
        return name.contains(lowerQuery) ||
            brand.contains(lowerQuery) ||
            desc.contains(lowerQuery);
      }).toList();
    }

    if (params.filters != null && params.filters!.isNotEmpty) {
      if (params.filters!.containsKey('brand')) {
        final fb = params.filters!['brand']?.toString().toLowerCase() ?? '';
        if (fb.isNotEmpty) {
          matched = matched.where((p) => (p.brand ?? '').toLowerCase() == fb).toList();
        }
      }

      if (params.filters!.containsKey('category_id')) {
        final raw = params.filters!['category_id'];
        final int? cid = raw is int ? raw : int.tryParse(raw?.toString() ?? '');
        if (cid != null) {
          matched = matched.where((p) {
            final cats = p.categoryIds;
            return cats.contains(cid);
            return false;
          }).toList();
        }
      }

      final minP = _parseDouble(params.filters!['price_min']);
      final maxP = _parseDouble(params.filters!['price_max']);

      if (minP != null) matched = matched.where((p) => _getPrice(p) >= minP).toList();
      if (maxP != null) matched = matched.where((p) => _getPrice(p) <= maxP).toList();
    }

    if (params.sort == 'price_asc') {
      matched.sort((a, b) => _getPrice(a).compareTo(_getPrice(b)));
    } else if (params.sort == 'price_desc') {
      matched.sort((a, b) => _getPrice(b).compareTo(_getPrice(a)));
    } else if (params.sort == 'rating') {
      matched.sort((a, b) => _getRating(b).compareTo(_getRating(a)));
    }

    final total = matched.length;
    final offset = int.tryParse(params.cursor ?? '0') ?? 0;

    final paged = (offset >= total) ? <ProductEntity>[] : matched.skip(offset).take(params.limit).toList();

    final nextOffset = offset + params.limit;
    final nextCursor = nextOffset >= total ? null : nextOffset.toString();

    final facets = _buildFacets(matched);

    return SearchResult(
      products: paged,
      total: total,
      limit: params.limit,
      cursor: params.cursor,
      nextCursor: nextCursor,
      facets: facets,
    );
  }

  double _getPrice(ProductEntity p) {
    return (p.price as num).toDouble();
    return 0;
  }

  double _getRating(ProductEntity p) {
    return (p.rating as num).toDouble();
    return 0;
  }

  double? _parseDouble(dynamic v) {
    if (v is num) return v.toDouble();
    if (v == null) return null;
    return double.tryParse(v.toString());
  }

  Facets _buildFacets(List<ProductEntity> products) {
    if (products.isEmpty) return const Facets();

    final Map<String, int> brandCount = {};
    final Map<int, int> catCount = {};
    double? minP;
    double? maxP;

    for (final p in products) {
      final b = (p.brand ?? '').trim();
      if (b.isNotEmpty) brandCount[b] = (brandCount[b] ?? 0) + 1;

      final cats = p.categoryIds;
      for (final cid in cats) {
        catCount[cid] = (catCount[cid] ?? 0) + 1;
      }
    
      final double price = _getPrice(p);
      minP = (minP == null || price < minP) ? price : minP;
      maxP = (maxP == null || price > maxP) ? price : maxP;
    }

    final brands = brandCount.entries.map((e) => FacetItem(id: e.key, name: e.key, count: e.value)).toList();
    final categories = catCount.entries.map((e) => FacetItem(id: e.key.toString(), name: 'Category ${e.key}', count: e.value)).toList();

    return Facets(brands: brands, categories: categories, minPrice: minP, maxPrice: maxP);
  }
}
