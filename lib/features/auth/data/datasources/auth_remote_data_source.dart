// ملف مسؤول عن استدعاء واجهات برمجة تطبيقات المصادقة البعيدة.

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

