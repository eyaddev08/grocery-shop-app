import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../entities/auth_token.dart';
import '../repositories/auth_repository.dart';

class RefreshTokenUseCase {
  RefreshTokenUseCase(this.repository);
  final AuthRepository repository;

  Future<Either<Failure, AuthToken>> call(String refreshToken) =>
      repository.refreshToken(refreshToken);
}
