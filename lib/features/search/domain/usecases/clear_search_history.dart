import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../repositories/search_repository.dart';

class ClearSearchHistoryUseCase {

  ClearSearchHistoryUseCase(this.repository);
  final SearchRepository repository;

  Future<Either<Failure, void>> call() async => await repository.clearSearchHistory();
}
