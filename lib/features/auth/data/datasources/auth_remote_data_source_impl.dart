import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../../../core/error/exception.dart';
import '../models/auth_token_model.dart';
import '../models/user_model.dart';
import '../models/user_register_model.dart';


abstract class AuthRemoteDataSource {
  Future<AuthTokenModel> login(String email, String password);
  Future<UserModel> register(UserRegisterModel model);
  Future<void> requestPasswordReset(String email);
  Future<String> verifyResetCode(String email, String code);
  Future<void> resetPassword({
    required String token,
    required String password,
    required String passwordConfirmation,
  });
  Future<AuthTokenModel> refreshToken(String refreshToken);
}


class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  AuthRemoteDataSourceImpl({required this.client});
  final Dio client;

  @override
  Future<AuthTokenModel> login(String email, String password) async {
    try {
      final emailValue = email.trim().toLowerCase();
      final passwordValue = password;

      debugPrint('[Remote]✅ login called for $email');

      await Future<void>.delayed(const Duration(seconds: 1));

      if (emailValue == 'eyaddev08@gmail.com' &&
          passwordValue == 'e12345678A') {
        const token = 'fake_token_123456';
        debugPrint('[Remote]✅ success token: $token');
        return const AuthTokenModel(
            accessToken: token, refreshToken: token, expiresIn: 3600);
      }

      throw ServerException('❌Invalid credentials');
    } catch (e, st) {
      debugPrint('[Remote]❌ error: $e\n$st');
      throw ServerException('❌ Server connection failed');
    }
  }

  @override
  Future<UserModel> register(UserRegisterModel model) async {
    try {
      final userModel = model;
      debugPrint('[Remote] ✅ Reset Password called for ${model.email}');

      await Future<void>.delayed(const Duration(seconds: 1));
     
      if (userModel.name == 'Eyad' ||
          userModel.email == 'eyaddev@gmail.com' ||
          userModel.password == 'e1234567A' ||
          userModel.passwordConfirmation == 'e1234567A') {
        const token = 'fake_token_123456';
        debugPrint('[Remote] ✅ success token: $token');
        return UserModel.fromJson(userModel.toJson());
      }

      throw ServerException('❌ Invalid credentials');
    } catch (e, st) {
      debugPrint('[Remote] ❌ error: $e\n$st');
      throw ServerException('❌ Server connection failed');
    }
  }

  @override
  Future<void> requestPasswordReset(String email) async {
    try {
      final forgotemail = email.trim().toLowerCase();

      debugPrint('[Remote]✅ Request Password called for $forgotemail');

      await Future<void>.delayed(const Duration(seconds: 1));

      if (forgotemail == 'eyaddev08@gmail.com') {
        const token = 'fake_token_123456';
        debugPrint('[Remote]✅ success token: $token');
        return;
      }

      throw ServerException('❌ Invalid credentials');
    } catch (e, st) {
      debugPrint('[Remote] ❌ error: $e\n$st');
      throw ServerException('❌ Server connection failed');
    }
  }

  @override
  Future<String> verifyResetCode(String email, String code) async {
    try {
      final verifyemail = email.trim().toLowerCase();
      final verifyCode = code;

      debugPrint('[Remote]✅ Verify Reset Code called for $verifyemail');

      await Future<void>.delayed(const Duration(seconds: 1));

      if (verifyemail == 'eyaddev08@gmail.com' || verifyCode == '1234') {
        const token = 'fake_token_123456';
        debugPrint('[Remote]✅ success token: $token');
        return verifyCode;
      }

      throw ServerException('❌ Invalid credentials');
    } catch (e, st) {
      debugPrint('[Remote] ❌ error: $e\n$st');
      throw ServerException('❌ Server connection failed');
    }

  }

  @override
  Future<void> resetPassword({
    required String token,
    required String password,
    required String passwordConfirmation,
  }) async {
    try {
      final resetPass = password;
      final resetPassConf = passwordConfirmation;

      debugPrint('[Remote] ✅ Reset Password called for $resetPass');

      await Future<void>.delayed(const Duration(seconds: 1));

      if (resetPass == 'e1234567A' || resetPassConf == 'e1234567A') {
        const token = 'fake_token_123456';
        debugPrint('[Remote] ✅ success token: $token');
        return;
      }

      throw ServerException('❌ Invalid credentials');
    } catch (e, st) {
      debugPrint('[Remote] ❌ error: $e\n$st');
      throw ServerException('❌ Server connection failed');
    }
  }

  @override
  Future<AuthTokenModel> refreshToken(String refreshToken) async {
    try {
      final response = await client.post<Map<String, dynamic>>(
        '/api/auth/refresh',
        data: {'refresh_token': refreshToken},
      );

      if (response.statusCode == 200) {
        final data =
            (response.data?['data'] ?? response.data) as Map<String, dynamic>;
        return AuthTokenModel.fromJson(data);
      } else {
        throw ServerException('Token refresh failed');
      }
    } on DioException catch (e) {
      if (e.response != null) {
        throw ServerException('Token refresh failed');
      }
      throw ServerException(e.message ?? 'Network error');
    } catch (e) {
      if (e is ServerException || e is ValidationException) {
        rethrow;
      }
      throw ServerException(e.toString());
    }
  }
}
