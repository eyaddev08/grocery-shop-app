// lib/features/search/domain/repositories/search_repository.dart
// واجهة SearchRepository على مستوى الـ Domain
import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../entities/suggestion.dart';
import '../entities/search_result.dart';

abstract class SearchRepository {
  Future<Either<Failure, List<Suggestion>>> getSuggestions(String query);

  Future<Either<Failure, SearchResult>> search({
    required String query,
    Map<String, dynamic>? filters,
    String? cursor,
    int limit = 20,
    String sort = 'relevance',
  });

  Future<Either<Failure, void>> clearSearchHistory();
  Future<Either<Failure, void>> removeSearchHistoryItem(String item);
}
