import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../repositories/auth_repository.dart';

class ResetPasswordUseCase {
  ResetPasswordUseCase(this.repository);
  final AuthRepository repository;

  Future<Either<Failure, void>> call({
    required String token,
    required String password,
    required String passwordConfirmation,
  }) =>
      repository.resetPassword(
        token: token,
        password: password,
        passwordConfirmation: passwordConfirmation,
      );
}
