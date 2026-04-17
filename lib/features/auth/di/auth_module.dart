import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';

import '../../../core/network/api_client.dart';
import '../../../core/services/dio_auth_interceptor.dart';
import '../data/datasources/auth_local_data_source_impl.dart';
import '../data/datasources/auth_remote_data_source_impl.dart';
import '../data/repositories/auth_repository_impl.dart';
import '../domain/repositories/auth_repository.dart';
import '../domain/usecases/login.dart';
import '../domain/usecases/refresh_token.dart';
import '../domain/usecases/register.dart';
import '../domain/usecases/request_password_reset.dart';
import '../domain/usecases/reset_password.dart';
import '../domain/usecases/verify_reset_code.dart';
import '../presentation/manager/auth_cubit.dart';

class AuthModule {
  static void init(GetIt sl) {
    // FlutterSecureStorage
    if (!sl.isRegistered<FlutterSecureStorage>()) {
      sl.registerLazySingleton<FlutterSecureStorage>(
          () => const FlutterSecureStorage());
    }
    // Dio with auth interceptor
    if (!sl.isRegistered<Dio>(instanceName: 'authDio')) {
      final dio = Dio();
      ApiClient(dio);
      final storage = sl<FlutterSecureStorage>();
      dio.interceptors.add(DioAuthInterceptor(storage: storage, dio: dio));
      sl.registerLazySingleton<Dio>(() => dio, instanceName: 'authDio');
    }
    // Data Sources
    if (!sl.isRegistered<AuthRemoteDataSource>()) {
      sl.registerLazySingleton<AuthRemoteDataSource>(
        () =>
            AuthRemoteDataSourceImpl(client: sl<Dio>(instanceName: 'authDio')),
      );
    }
    if (!sl.isRegistered<AuthLocalDataSource>()) {
      sl.registerLazySingleton<AuthLocalDataSource>(
        () => AuthLocalDataSourceImpl(storage: sl<FlutterSecureStorage>()),
      );
    }
    // Interceptor (requires data sources)
    sl<Dio>().interceptors.add(
          DioAuthInterceptor(
            storage: sl<FlutterSecureStorage>(),
            dio: sl<Dio>(),
          ),
        );
    // Repository
    if (!sl.isRegistered<AuthRepository>()) {
      sl.registerLazySingleton<AuthRepository>(
        () => AuthRepositoryImpl(
          remoteDataSource: sl<AuthRemoteDataSource>(),
          localDataSource: sl<AuthLocalDataSource>(),
        ),
      );
    }
    // Use Cases
    if (!sl.isRegistered<LoginUseCase>()) {
      sl.registerLazySingleton<LoginUseCase>(
          () => LoginUseCase(sl<AuthRepository>()));
    }
    if (!sl.isRegistered<RegisterUseCase>()) {
      sl.registerLazySingleton<RegisterUseCase>(
          () => RegisterUseCase(sl<AuthRepository>()));
    }
    if (!sl.isRegistered<RequestPasswordResetUseCase>()) {
      sl.registerLazySingleton<RequestPasswordResetUseCase>(
          () => RequestPasswordResetUseCase(sl<AuthRepository>()));
    }
    if (!sl.isRegistered<VerifyResetCodeUseCase>()) {
      sl.registerLazySingleton<VerifyResetCodeUseCase>(
          () => VerifyResetCodeUseCase(sl<AuthRepository>()));
    }
    if (!sl.isRegistered<ResetPasswordUseCase>()) {
      sl.registerLazySingleton<ResetPasswordUseCase>(
          () => ResetPasswordUseCase(sl<AuthRepository>()));
    }
    if (!sl.isRegistered<RefreshTokenUseCase>()) {
      sl.registerLazySingleton<RefreshTokenUseCase>(
          () => RefreshTokenUseCase(sl<AuthRepository>()));
    }
    // Cubit
    if (!sl.isRegistered<AuthCubit>()) {
      sl.registerFactory<AuthCubit>(
        () => AuthCubit(
          loginUseCase: sl<LoginUseCase>(),
          registerUseCase: sl<RegisterUseCase>(),
          requestPasswordResetUseCase: sl<RequestPasswordResetUseCase>(),
          verifyResetCodeUseCase: sl<VerifyResetCodeUseCase>(),
          resetPasswordUseCase: sl<ResetPasswordUseCase>(),
          refreshTokenUseCase: sl<RefreshTokenUseCase>(),
          repository: sl<AuthRepository>(),
        ),
      );
    }
  }
}
