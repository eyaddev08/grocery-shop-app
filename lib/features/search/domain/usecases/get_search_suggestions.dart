import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../../../products/domain/repositories/product_repository.dart';
import '../entities/suggestion.dart';
import '../repositories/search_repository.dart';

class GetSearchSuggestionsUseCase {
  GetSearchSuggestionsUseCase({
    required this.searchRepository,
    required this.productRepository,
  });

  final SearchRepository searchRepository;
  final ProductRepository productRepository;
    Future<Either<Failure, List<Suggestion>>> call(String query) async {
      final q = query.trim();
      if (q.isNotEmpty && q.length < 2) {
        return Future.value(const Right(<Suggestion>[]));
        return const Right(<Suggestion>[]);
      }
      return searchRepository.getSuggestions(q);
      if (q.isEmpty) {
        final historyResult = await searchRepository.getSearchHistory();
        return historyResult.fold((f) {
          final demo = ['recommended', 'waterproof bag', 'shoes', 'apple'];
          return Right(demo.map((t) => Suggestion(text: t)).toList());
        }, (history) {
          if (history.isEmpty) {
            final demo = ['recommended', 'waterproof bag', 'shoes', 'apple'];
            return Right(demo.map((t) => Suggestion(text: t)).toList());
          }
          final suggestions = history
              .map((t) => Suggestion(text: t, type: SuggestionType.history))
              .toList();
          return Right(suggestions);
        });
      }
      final remoteResult = await searchRepository.getSuggestions(q);
      return remoteResult.fold(
        (failure) async {
          final productsResult = await productRepository.getProducts();
          return productsResult.fold((f) => Left(f), (products) {
            final lower = q.toLowerCase();
            final Set<String> seen = {};
            final List<Suggestion> out = [];
            for (final p in products) {
              final name = p.name.toLowerCase();
              if (name.contains(lower) && !seen.contains(name)) {
                seen.add(name);
                out.add(Suggestion(text: p.name, subtitle: p.brand));
              }
            }
            for (final p in products) {
              final brand = (p.brand ?? '').toLowerCase();
              if (brand.contains(lower) && !seen.contains('brand:$brand')) {
                seen.add('brand:$brand');
                out.add(Suggestion(
                    text: p.brand ?? '', type: SuggestionType.brand));
              }
            }
            final limited = out.take(30).toList();
            return Right(limited);
          });
        },
        (success) => Right(success),
      );
    }
  }
