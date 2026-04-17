import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../data/datasources/payment_remote_data_source.dart';
import '../data/datasources/payment_remote_data_source_impl.dart';
import '../data/repositories/payment_repository_impl.dart';
import '../domain/repositories/payment_repository.dart';
import '../domain/usecase/tokenize_and_pay.dart';
import '../presentation/manager/payment_cubit/payment_cubit.dart';

class PaymentModule {
  static Future<void> init(GetIt sl) async {
    // remote datasource (uses mock logic until a real API exists)
    if (!sl.isRegistered<PaymentRemoteDataSource>()) {
      sl.registerLazySingleton<PaymentRemoteDataSource>(
        () => PaymentRemoteDataSourceImpl(
          client: sl<Dio>(instanceName: 'authDio'),
        ),
      );
    }

    // Repository
    if (!sl.isRegistered<PaymentRepository>()) {
      sl.registerLazySingleton<PaymentRepository>(
        () => PaymentRepositoryImpl(
          remoteDataSource: sl(),
          networkInfo: sl(),
        ),
      );
    }

    // Use Case
    if (!sl.isRegistered<TokenizeAndPayUseCase>()) {
      sl.registerLazySingleton(() => TokenizeAndPayUseCase(sl()));
    }

    // Cubit
    if (!sl.isRegistered<PaymentCubit>()) {
      sl.registerFactory(() => PaymentCubit(
            tokenizeAndPayUseCase: sl(),
            createOrderUseCase: sl(),
            clearCartUseCase: sl(),
          ));
    }
  }
}
