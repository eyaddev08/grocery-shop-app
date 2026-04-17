// /lib/features/profile/domain/usecases/logout.dart
// Use case for logging out user.
import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../repositories/profile_repository.dart';

class LogoutUseCase {
  LogoutUseCase(this.repository);
  final ProfileRepository repository;

  Future<Either<Failure, Unit>> call() async => await repository.logout();
}
