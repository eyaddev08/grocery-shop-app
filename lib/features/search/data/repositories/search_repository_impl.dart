import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import '../../../../core/error/failure.dart';
import '../../domain/entities/suggestion.dart';
import '../../domain/entities/search_result.dart';
import '../../domain/repositories/search_repository.dart';
import '../datasources/search_local_data_source.dart';
import '../datasources/search_remote_data_source.dart';
import '../../../products/domain/repositories/product_repository.dart';

class SearchRepositoryImpl implements SearchRepository {
  final ProductRepository productRepository;
  final SearchRemoteDataSource? remoteDataSource;
  final SearchLocalDataSource? localDataSource;

  SearchRepositoryImpl({
    required this.productRepository,
    this.remoteDataSource,
    this.localDataSource,
  });

  @override
  Future<Either<Failure, List<Suggestion>>> getSuggestions(String query) async {
    final q = query.trim();

    if (q.isEmpty) {
       final demo = ['recommended', 'waterproof bag', 'shoes', 'apple'];

      try {
        if (localDataSource != null) {
          final history = await localDataSource!.getSearchHistory();
          final suggestions = history
              .map((t) => Suggestion(text: t, type: SuggestionType.history))
              .toList();
         return Right(suggestions);
        }

       return Right(demo
            .map((t) => Suggestion(text: t, type: SuggestionType.keyword))
            .toList());
      } catch (e, st) {
        debugPrint('SearchRepository.getSuggestions failed:  $e\n$st');
        return Left(Failure(e.toString()));
      }
    }

    if (remoteDataSource != null) {
      try {
        final remote = await remoteDataSource!.getSuggestions(q);
        final List<Suggestion> results = remote
            .map((m) =>
                Suggestion(text: m.text, type: m.type, subtitle: m.subtitle))
            .toList();
        try {
          await localDataSource?.cacheSuggestions(remote);
        } catch (_) {}
        return Right(results);
      } catch (e) {
      }
    }

    // Fallback: اقتراحات مبنية من ProductRepository (محلي)
    try {
      final either = await productRepository.getProducts();
      return either.fold((f) => Left(f), (products) {
        final lower = q.toLowerCase();
        final Set<String> seen = {};
        final List<Suggestion> out = [];

        // from names
        for (final p in products) {
          final name = p.name.toLowerCase();
          if (name.contains(lower) && !seen.contains(name)) {
            seen.add(name);
            out.add(Suggestion(
                text: p.name, type: SuggestionType.keyword, subtitle: p.brand));
          }
        }

        // from brands
        for (final p in products) {
          final brand = (p.brand ?? '').toLowerCase();
          if (brand.contains(lower) && !seen.contains('brand:$brand')) {
            seen.add('brand:$brand');
            out.add(
                Suggestion(text: p.brand ?? '', type: SuggestionType.brand));
          }
        }
        final limited = out.take(30).toList();
        return Right(limited);
      });
    } catch (e) {
      return Left(Failure('Enternal Error: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, SearchResult>> search({
    required String query,
    Map<String, dynamic>? filters,
    String? cursor,
    int limit = 20,
    String sort = 'relevance',
  }) async {
    final q = query.trim();

    if (remoteDataSource != null) {
      try {
        final remoteModel = await remoteDataSource!.search(
          query: q,
          filters: filters,
          cursor: cursor,
          limit: limit,
          sort: sort,
        );

        if (cursor == null && localDataSource != null) {
         try {
            await localDataSource!.cacheLastResult(remoteModel);
          } catch (e) {
            debugPrint('Failed to cache remote result: $e');
          }

          if (q.isNotEmpty) {
            try {
              await localDataSource!.addSearchToHistory(q);
            } catch (e) {
              debugPrint('Failed to add (remote) search history: $e');
            }
          }
        }

        return Right(remoteModel);
      } catch (e) {
        // Fallback to local
      }
    }

    if (localDataSource == null) {
      return Left(
          Failure('Local data source not available for fallback search.'));
    }

    try {
      final either = await productRepository.getProducts();
      return await either.fold((failure) async => Left(failure),
          (allProducts) async {
        final result = await localDataSource!.searchInList(
          products: allProducts,
          query: q,
          filters: filters,
          cursor: cursor,
          limit: limit,
          sort: sort,
        );

        if (cursor == null && localDataSource != null) {
          try {
            await localDataSource!.cacheLastResult(result);
          } catch (e) {
            debugPrint('Failed to cache last result: $e');
          }

          if (q.isNotEmpty) {
            try {
              await localDataSource!.addSearchToHistory(q);
            } catch (e) {
              debugPrint('Failed to add search history: $e');
            }
          }
        }

        return Right(result);
      });
    } catch (e) {
      return Left(Failure('Internal error${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, void>> clearSearchHistory() async {
    try {
      if (localDataSource != null) {
        await localDataSource!.clearSearchHistory();
      }
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> removeSearchHistoryItem(String item) async {
    try {
      if (localDataSource != null) {
        await localDataSource!.removeSearchHistoryItem(item);
      }
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure(message: e.toString()));
    }
  }
}
