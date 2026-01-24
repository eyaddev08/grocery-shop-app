// تنفيذ مصدر بيانات المصادقة البعيدة
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../../../core/error/exception.dart';
import '../models/auth_token_model.dart';
import '../models/user_model.dart';
import '../models/user_register_model.dart';
import 'auth_remote_data_source.dart';

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
    // try {
    //   final response = await client.post<Map<String, dynamic>>(
    //     '/api/auth/login',
    //     data: {
    //       'email': email,
    //       'password': password,
    //     },
    //   );

    //   if (response.statusCode == 200) {
    //     final responseData = response.data;
    //     if (responseData == null) {
    //       throw ServerException('Invalid response');
    //     }
    //     final data =
    //         (responseData['data'] ?? responseData) as Map<String, dynamic>;
    //     return AuthTokenModel.fromJson(data);
    //   } else {
    //     final message =
    //         (response.data as Map<String, dynamic>?)?['message'] as String? ??
    //             'Login failed';
    //     throw ServerException(message);
    //   }
    // } on DioException catch (e) {
    //   if (e.response != null) {
    //     final statusCode = e.response!.statusCode;
    //     final data = e.response!.data;

    //     if (statusCode == 401) {
    //       throw ServerException(
    //           data['message'] as String? ?? 'Invalid credentials');
    //     } else if (statusCode == 422) {
    //       final errors = data['errors'] as Map<String, dynamic>?;

    //       if (errors != null) {
    //         final errorMap =
    //             errors.map((k, v) => MapEntry(k, (v as List).cast<String>()));

    //         throw ValidationException(errorMap);
    //       }
    //     }
    //     throw ServerException(data['message'] as String? ?? 'Server error');
    //   }
    //   throw NetworkException(e.message ?? 'Network error');
    // } catch (e) {
    //   if (e is ServerException ||
    //       e is ValidationException ||
    //       e is NetworkException) {
    //     rethrow;
    //   }
    //   throw ServerException(e.toString());
    // }
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
    // try {
    //   final response = await client.post<Map<String, dynamic>>(
    //     '/api/auth/register',
    //     data: model.toJson(),
    //   );

    //   if (response.statusCode == 201 || response.statusCode == 200) {
    //     final responseData = response.data;
    //     if (responseData == null) {
    //       throw ServerException('Invalid response');
    //     }
    //     final data =
    //         (responseData['data'] ?? responseData) as Map<String, dynamic>;
    //     return UserModel.fromJson(data);
    //   } else {
    //     final message =
    //         (response.data as Map<String, dynamic>?)?['message'] as String? ??
    //             'Registration failed';

    //     throw ServerException(message);
    //   }
    // } on DioException catch (e) {
    //   if (e.response != null) {
    //     final statusCode = e.response!.statusCode;
    //     final data = e.response!.data;

    //     if (statusCode == 422) {
    //       final errors = data['errors'] as Map<String, dynamic>?;
    //       if (errors != null) {
    //         final errorMap =
    //             errors.map((k, v) => MapEntry(k, (v as List).cast<String>()));
    //         throw ValidationException(errorMap);
    //       }
    //     }
    //     throw ServerException(data['message'] as String? ?? 'Server error');
    //   }
    //   throw NetworkException(e.message ?? 'Network error');
    // } catch (e) {
    //   if (e is ServerException ||
    //       e is ValidationException ||
    //       e is NetworkException) {
    //     rethrow;
    //   }
    //   throw ServerException(e.toString());
    // }
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
    // try {
    //   final response = await client.post<Map<String, dynamic>>(
    //     '/api/auth/forgot',
    //     data: {'email': email},
    //   );

    //   if (response.statusCode != 200) {
    //     final message =
    //         response.data?['message'] as String? ?? 'Request failed';
    //     throw ServerException(message);
    //   }
    // } on DioException catch (e) {
    //   if (e.response != null) {
    //     final data = e.response!.data;
    //     throw ServerException(data['message'] as String? ?? 'Server error');
    //   }
    //   throw NetworkException(e.message ?? 'Network error');
    // } catch (e) {
    //   if (e is ServerException || e is NetworkException) {
    //     rethrow;
    //   }
    //   throw ServerException(e.toString());
    // }
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
    // try {
    //   final response = await client.post<Map<String, dynamic>>(
    //     '/api/auth/verify-reset',
    //     data: {
    //       'email': email,
    //       'code': code,
    //     },
    //   );

    //   if (response.statusCode == 200) {
    //     return response.data?['token'] as String? ?? '';
    //   } else {
    //     final message =
    //         response.data?['message'] as String? ?? 'Verification failed';
    //     throw ServerException(message);
    //   }
    // } on DioException catch (e) {
    //   if (e.response != null) {
    //     final data = e.response!.data;
    //     throw ServerException(data['message'] as String? ?? 'Server error');
    //   }
    //   throw NetworkException(e.message ?? 'Network error');
    // } catch (e) {
    //   if (e is ServerException || e is NetworkException) {
    //     rethrow;
    //   }
    //   throw ServerException(e.toString());
    // }
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
    // try {
    //   final response = await client.post<Map<String, dynamic>>(
    //     '/api/auth/reset',
    //     data: {
    //       'token': token,
    //       'password': password,
    //       'password_confirmation': passwordConfirmation,
    //     },
    //   );

    //   if (response.statusCode != 200) {
    //     final message = response.data?['message'] as String? ?? 'Reset failed';
    //     throw ServerException(message);
    //   }
    // } on DioException catch (e) {
    //   if (e.response != null) {
    //     final statusCode = e.response!.statusCode;
    //     final data = e.response!.data;

    //     if (statusCode == 422) {
    //       final errors = data['errors'] as Map<String, dynamic>?;
    //       if (errors != null) {
    //         final errorMap =
    //             errors.map((k, v) => MapEntry(k, (v as List).cast<String>()));
    //         throw ValidationException(errorMap);
    //       }
    //     }
    //     throw ServerException(data['message'] as String? ?? 'Server error');
    //   }
    //   throw NetworkException(e.message ?? 'Network error');
    // } catch (e) {
    //   if (e is ServerException ||
    //       e is ValidationException ||
    //       e is NetworkException) {
    //     rethrow;
    //   }
    //   throw ServerException(e.toString());
    // }
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
      throw NetworkException(e.message ?? 'Network error');
    } catch (e) {
      if (e is ServerException || e is NetworkException) {
        rethrow;
      }
      throw ServerException(e.toString());
    }
  }
}
