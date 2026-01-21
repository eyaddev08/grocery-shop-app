import 'package:equatable/equatable.dart';
import '../../../products/domain/entities/product_entity.dart';

class FacetItem extends Equatable {
  final String id;
  final String name;
  final int count;

  const FacetItem({required this.id, required this.name, required this.count});

  @override
  List<Object?> get props => [id, name, count];
}

class Facets extends Equatable {
  final List<FacetItem> brands;
  final List<FacetItem> categories;
  final double? minPrice;
  final double? maxPrice;

  const Facets({
    this.brands = const [],
    this.categories = const [],
    this.minPrice,
    this.maxPrice,
  });

  bool get isEmpty =>
      brands.isEmpty &&
      categories.isEmpty &&
      minPrice == null &&
      maxPrice == null;

  @override
  List<Object?> get props => [brands, categories, minPrice, maxPrice];
}

class SearchResult extends Equatable {
  final List<ProductEntity> products;
  final int total;
  final int limit;
  final String? cursor; // current offset as string
  final String? nextCursor;
  final Facets facets;

  const SearchResult({
    required this.products,
    required this.total,
    required this.limit,
    this.cursor,
    this.nextCursor,
    this.facets = const Facets(),
  });

  SearchResult copyWith({
    List<ProductEntity>? products,
    int? total,
    int? limit,
    String? cursor,
    String? nextCursor,
    Facets? facets,
  }) => SearchResult(
      products: products ?? this.products,
      total: total ?? this.total,
      limit: limit ?? this.limit,
      cursor: cursor ?? this.cursor,
      nextCursor: nextCursor ?? this.nextCursor,
      facets: facets ?? this.facets,
    );

  @override
  List<Object?> get props =>
      [products, total, limit, cursor, nextCursor, facets];
}
