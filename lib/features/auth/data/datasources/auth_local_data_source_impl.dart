import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../models/auth_token_model.dart';
import '../../../../core/constants/secure_storage_keys.dart';

abstract class AuthLocalDataSource {
  Future<void> saveTokens(AuthTokenModel token);
  Future<AuthTokenModel?> getTokens();
  Future<void> deleteTokens();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  AuthLocalDataSourceImpl({required this.storage});
  final FlutterSecureStorage storage;

  @override
  Future<void> saveTokens(AuthTokenModel token) async {
    await storage.write(
        key: SecureStorageKeys.accessToken, value: token.accessToken);
    await storage.write(
        key: SecureStorageKeys.refreshToken, value: token.refreshToken);
    await storage.write(
        key: SecureStorageKeys.tokenExpiresIn,
        value: token.expiresIn.toString());
    await storage.write(
        key: SecureStorageKeys.tokenType, value: token.tokenType);
  }

  @override
  Future<AuthTokenModel?> getTokens() async {
    final accessToken = await storage.read(key: SecureStorageKeys.accessToken);
    final refreshToken =
        await storage.read(key: SecureStorageKeys.refreshToken);
    final expiresInStr =
        await storage.read(key: SecureStorageKeys.tokenExpiresIn);
    final tokenType = await storage.read(key: SecureStorageKeys.tokenType);

    if (accessToken == null || refreshToken == null) {
      return null;
    }

    final expiresIn = int.tryParse(expiresInStr ?? '3600') ?? 3600;

    return AuthTokenModel(
      accessToken: accessToken,
      refreshToken: refreshToken,
      expiresIn: expiresIn,
      tokenType: tokenType ?? 'bearer',
    );
  }

  @override
  Future<void> deleteTokens() async {
    await storage.delete(key: SecureStorageKeys.accessToken);
    await storage.delete(key: SecureStorageKeys.refreshToken);
    await storage.delete(key: SecureStorageKeys.tokenExpiresIn);
    await storage.delete(key: SecureStorageKeys.tokenType);
  }
}
