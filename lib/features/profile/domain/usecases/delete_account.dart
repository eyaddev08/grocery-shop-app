import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../repositories/profile_repository.dart';

class DeleteAccountUseCase {
  DeleteAccountUseCase(this.repository);
  final ProfileRepository repository;

  Future<Either<Failure, Unit>> call() async =>
      await repository.deleteAccount();
}
