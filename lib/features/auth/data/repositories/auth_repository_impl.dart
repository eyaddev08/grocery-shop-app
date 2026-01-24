// ملف مسؤول عن تنفيذ واجهة المستودع لميزة المصادقة.

import 'package:dartz/dartz.dart';
import '../../../../core/error/exception.dart';
import '../../../../core/error/failure.dart';
import '../../domain/entities/auth_token.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_local_data_source.dart';
import '../datasources/auth_remote_data_source.dart';
import '../models/auth_token_model.dart';
import '../models/user_register_model.dart';

class AuthRepositoryImpl implements AuthRepository {

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;

  @override
  Future<Either<Failure, AuthToken>> login(String email, String password) async {
    try {
      final tokenModel = await remoteDataSource.login(email, password);
      await localDataSource.saveTokens(tokenModel);
      return Right(tokenModel);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message ?? 'Server error'));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message ?? 'Network error'));
    } on ValidationException catch (e) {
      final errorMessage = e.errors.values.firstOrNull?.firstOrNull ?? 'Validation error';
      return Left(ValidationFailure(message: errorMessage, errors: e.errors));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, User>> register({
    required String name,
    required String email,
    required String password,
    required String passwordConfirmation,
  }) async {
    try {
      final user = await remoteDataSource.register(
        UserRegisterModel(
          name: name,
          email: email,
          password: password,
          passwordConfirmation: passwordConfirmation,
        ),
      );
      return Right(user);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message ?? 'Server error'));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message ?? 'Network error'));
    } on ValidationException catch (e) {
      final errorMessage = e.errors.values.firstOrNull?.firstOrNull ?? 'Validation error';
      return Left(ValidationFailure(message: errorMessage, errors: e.errors));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> requestPasswordReset(String email) async {
    try {
      await remoteDataSource.requestPasswordReset(email);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message ?? 'Server error'));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message ?? 'Network error'));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> verifyResetCode(String email, String code) async {
    try {
      final token = await remoteDataSource.verifyResetCode(email, code);
      return Right(token);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message ?? 'Server error'));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message ?? 'Network error'));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> resetPassword({
    required String token,
    required String password,
    required String passwordConfirmation,
  }) async {
    try {
      await remoteDataSource.resetPassword(
        token: token,
        password: password,
        passwordConfirmation: passwordConfirmation,
      );
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message ?? 'Server error'));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message ?? 'Network error'));
    } on ValidationException catch (e) {
      final errorMessage = e.errors.values.firstOrNull?.firstOrNull ?? 'Validation error';
      return Left(ValidationFailure(message: errorMessage, errors: e.errors));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, AuthToken>> refreshToken(String refreshToken) async {
    try {
      final tokenModel = await remoteDataSource.refreshToken(refreshToken);
      await localDataSource.saveTokens(tokenModel);
      return Right(tokenModel);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message ?? 'Server error'));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message ?? 'Network error'));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      await localDataSource.deleteTokens();
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, AuthToken?>> getStoredTokens() async {
    try {
      final token = await localDataSource.getTokens();
      return Right(token);
    } catch (e) {
      return Left(CacheFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> saveTokens(AuthToken token) async {
    try {
      await localDataSource.saveTokens(AuthTokenModel(
        accessToken: token.accessToken,
        refreshToken: token.refreshToken,
        expiresIn: token.expiresIn,
        tokenType: token.tokenType,
      ));
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteTokens() async {
    try {
      await localDataSource.deleteTokens();
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure(message: e.toString()));
    }
  }
}

