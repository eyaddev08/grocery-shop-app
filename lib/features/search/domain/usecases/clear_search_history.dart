import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../repositories/search_repository.dart';

class ClearSearchHistory {
  final SearchRepository repository;

  ClearSearchHistory(this.repository);

  Future<Either<Failure, void>> call() async {
    return await repository.clearSearchHistory();
  }
}
