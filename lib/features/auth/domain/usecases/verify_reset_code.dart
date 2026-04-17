import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../repositories/auth_repository.dart';

class VerifyResetCodeUseCase {
  VerifyResetCodeUseCase(this.repository);
  final AuthRepository repository;

  Future<Either<Failure, String>> call(String email, String code) =>
      repository.verifyResetCode(email, code);
}
