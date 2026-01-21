
import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../entities/suggestion.dart';
import '../repositories/search_repository.dart';

class GetSearchSuggestions {
  final SearchRepository repository;

  GetSearchSuggestions(this.repository);

  Future<Either<Failure, List<Suggestion>>> call(String query) {
    final q = query.trim();

    if (q.isNotEmpty && q.length < 2) {
      return Future.value(const Right(<Suggestion>[]));
    }

    return repository.getSuggestions(q);
  }
}
