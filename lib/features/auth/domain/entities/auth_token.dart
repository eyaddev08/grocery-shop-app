// ملف مسؤول عن تعريف الكيانات الخاصة بالجلسة والمستخدم في طبقة المجال.

class AuthToken {

  const AuthToken({
    required this.accessToken,
    required this.refreshToken,
    required this.expiresIn,
    this.tokenType = 'bearer',
  });
  final String accessToken;
  final String refreshToken;
  final int expiresIn;
  final String tokenType;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AuthToken &&
          runtimeType == other.runtimeType &&
          accessToken == other.accessToken &&
          refreshToken == other.refreshToken;

  @override
  int get hashCode => accessToken.hashCode ^ refreshToken.hashCode;
}

