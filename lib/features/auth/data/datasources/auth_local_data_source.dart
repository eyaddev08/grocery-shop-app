// ملف مسؤول عن الوصول المحلي لتخزين وحذف وقراءة الرموز بأمان.

import '../models/auth_token_model.dart';

abstract class AuthLocalDataSource {
  Future<void> saveTokens(AuthTokenModel token);
  Future<AuthTokenModel?> getTokens();
  Future<void> deleteTokens();
}

