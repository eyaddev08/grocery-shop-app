// ملف مسؤول عن تعريف واجهة المستودع لميزة المصادقة.

import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../entities/auth_token.dart';
import '../entities/user.dart';

abstract class AuthRepository {
  Future<Either<Failure, AuthToken>> login(String email, String password);
  Future<Either<Failure, User>> register({
    required String name,
    required String email,
    required String password,
    required String passwordConfirmation,
  });
  Future<Either<Failure, void>> requestPasswordReset(String email);
  Future<Either<Failure, String>> verifyResetCode(String email, String code);
  Future<Either<Failure, void>> resetPassword({
    required String token,
    required String password,
    required String passwordConfirmation,
  });
  Future<Either<Failure, AuthToken>> refreshToken(String refreshToken);
  Future<Either<Failure, void>> logout();
  Future<Either<Failure, AuthToken?>> getStoredTokens();
  Future<Either<Failure, void>> saveTokens(AuthToken token);
  Future<Either<Failure, void>> deleteTokens();
}

