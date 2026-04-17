import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../entities/auth_token.dart';
import '../repositories/auth_repository.dart';

class LoginUseCase {

  LoginUseCase(this.repository);
  final AuthRepository repository;

  Future<Either<Failure, AuthToken>> call(String email, String password) => repository.login(email, password);
}

