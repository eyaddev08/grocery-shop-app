import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../repositories/search_repository.dart';

class RemoveSearchHistoryItemUseCase {

  RemoveSearchHistoryItemUseCase(this.repository);
  final SearchRepository repository;

  Future<Either<Failure, void>> call(String item) async => await repository.removeSearchHistoryItem(item);
}
