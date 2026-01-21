import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../entities/search_result.dart';
import '../repositories/search_repository.dart';

class SearchProductsParams {
  final String query;
  final Map<String, dynamic>? filters;
  final String? cursor;
  final int limit;
  final String sort;

  SearchProductsParams({
    required this.query,
    this.filters,
    this.cursor,
    this.limit = 20,
    this.sort = 'relevance',
  });
}

class SearchProducts {
  final SearchRepository repository;

  SearchProducts(this.repository);

  Future<Either<Failure, SearchResult>> call(SearchProductsParams params) {
    return repository.search(
      query: params.query,
      filters: params.filters,
      cursor: params.cursor,
      limit: params.limit,
      sort: params.sort,
    );
  }
}
