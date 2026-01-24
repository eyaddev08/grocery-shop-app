// ملف مسؤول عن نموذج تحويل بيانات رموز المصادقة بين الـ JSON والكيان.

import '../../domain/entities/auth_token.dart';

class AuthTokenModel extends AuthToken {
  const AuthTokenModel({
    required super.accessToken,
    required super.refreshToken,
    required super.expiresIn,
    super.tokenType,
  });

  factory AuthTokenModel.fromJson(Map<String, dynamic> json) {
    // Handle both string and object formats
    String accessToken;
    String refreshToken;
    int expiresIn;
    String tokenType = 'bearer';

    if (json['access_token'] is String) {
      accessToken = json['access_token'] as String;
    } else if (json['access_token'] is Map) {
      accessToken = (json['access_token'] as Map)['token'] as String? ?? '';
    } else {
      accessToken = json['accessToken'] as String? ?? '';
    }

    if (json['refresh_token'] is String) {
      refreshToken = json['refresh_token'] as String;
    } else if (json['refresh_token'] is Map) {
      refreshToken = (json['refresh_token'] as Map)['token'] as String? ?? '';
    } else {
      refreshToken = json['refreshToken'] as String? ?? '';
    }

    expiresIn = json['expires_in'] as int? ?? json['expiresIn'] as int? ?? 3600;
    tokenType = json['token_type'] as String? ?? json['tokenType'] as String? ?? 'bearer';

    return AuthTokenModel(
      accessToken: accessToken,
      refreshToken: refreshToken,
      expiresIn: expiresIn,
      tokenType: tokenType,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'access_token': accessToken,
      'refresh_token': refreshToken,
      'expires_in': expiresIn,
      'token_type': tokenType,
    };
  }
}

