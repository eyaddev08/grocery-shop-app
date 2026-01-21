import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../repositories/search_repository.dart';

class RemoveSearchHistoryItem {
  final SearchRepository repository;

  RemoveSearchHistoryItem(this.repository);

  Future<Either<Failure, void>> call(String item) async {
    return await repository.removeSearchHistoryItem(item);
  }
}
