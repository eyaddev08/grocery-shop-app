// ملف مسؤول عن اعتراض طلبات Dio وإضافة رمز التوثيق وتحديثه تلقائياً.

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../features/auth/presentation/manager/auth_cubit.dart';
import '../constants/secure_storage_keys.dart';

class DioAuthInterceptor extends Interceptor {
  final FlutterSecureStorage storage;
  final Dio dio;
  final AuthCubit? authCubit;

  DioAuthInterceptor({
    required this.storage,
    required this.dio,
    this.authCubit,
  });

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    // Attach access token if available
    final accessToken = await storage.read(key: SecureStorageKeys.accessToken);
    if (accessToken != null && accessToken.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $accessToken';
    }
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    // Handle 401 Unauthorized - try to refresh token
    if (err.response?.statusCode == 401) {
      try {
        final refreshToken = await storage.read(key: SecureStorageKeys.refreshToken);
        if (refreshToken != null && refreshToken.isNotEmpty) {
          // Attempt to refresh token
          final refreshResponse = await dio.post<Map<String, dynamic>>(
            '/api/auth/refresh',
            data: {'refresh_token': refreshToken},
          );

          if (refreshResponse.statusCode == 200) {
            final data = refreshResponse.data?['data'] ?? refreshResponse.data;
            final newAccessToken = data['access_token'] as String? ?? '';
            final newRefreshToken = data['refresh_token'] as String? ?? '';

            if (newAccessToken.isNotEmpty) {
              await storage.write(key: SecureStorageKeys.accessToken, value: newAccessToken);
              if (newRefreshToken.isNotEmpty) {
                await storage.write(key: SecureStorageKeys.refreshToken, value: newRefreshToken);
              }

              // Retry original request with new token
              final opts = err.requestOptions;
              opts.headers['Authorization'] = 'Bearer $newAccessToken';
              final response = await dio.fetch<Map<String, dynamic>>(opts);
              return handler.resolve(response);
            }
          }
        }

        // Refresh failed - logout user
        await storage.deleteAll();
        authCubit?.logout();
        return handler.reject(err);
      } catch (e) {
        // Refresh failed - logout user
        await storage.deleteAll();
        authCubit?.logout();
        return handler.reject(err);
      }
    }

    handler.next(err);
  }
}

