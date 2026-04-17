import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../repositories/profile_repository.dart';

class ChangePasswordUseCase {
  ChangePasswordUseCase(this.repository);
  final ProfileRepository repository;

  Future<Either<Failure, Unit>> call(
          String current, String newPassword) async =>
      await repository.changePassword(current, newPassword);
}
