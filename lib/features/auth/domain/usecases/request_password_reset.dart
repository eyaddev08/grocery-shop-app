import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../repositories/auth_repository.dart';

class RequestPasswordResetUseCase {
  RequestPasswordResetUseCase(this.repository);
  final AuthRepository repository;

  Future<Either<Failure, void>> call(String email) =>
      repository.requestPasswordReset(email);
}
