import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../data/datasources/order_local_data_source.dart';
import '../data/datasources/order_remote_data_source.dart';
import '../data/repositories/order_repository_impl.dart';
import '../domain/repositories/order_repository.dart';
import '../domain/usecases/cancel_order.dart';
import '../domain/usecases/create_orders.dart';
import '../domain/usecases/get_orders.dart';
import '../presentation/manager/order_cubit.dart';

class OrderModule {
  static Future<void> init(GetIt sl) async {
    // Order cache box (dynamic)

    if (!Hive.isBoxOpen('cached_orders')) {
      await Hive.openBox<String>('cached_orders');
    }

    // Data Source
    sl.registerLazySingleton<OrderLocalDataSource>(
      () => OrderLocalDataSourceImpl(box: Hive.box('cached_orders')),
    );

    sl.registerLazySingleton<OrderRemoteDataSource>(
      () => OrderRemoteDataSourceImpl(client: sl<Dio>()),
    );

    // ---- 3. Repositories ----
    sl.registerLazySingleton<OrderRepository>(
      () => OrderRepositoryImpl(
        localDataSource: sl(),
        remoteDataSource: sl(),
        networkInfo: sl(),
      ),
    );

    // Use Case
    sl.registerLazySingleton<GetOrdersUseCase>(() => GetOrdersUseCase(sl()));

    sl.registerLazySingleton(() => CreateOrderUseCase(sl()));

    sl.registerLazySingleton(() => CancelOrderUseCase(sl()));

    // Cubit
    sl.registerFactory(() => OrderCubit(
          getOrdersUseCase: sl<GetOrdersUseCase>(),
          createOrderUseCase: sl<CreateOrderUseCase>(),
          cancelOrderUseCase: sl<CancelOrderUseCase>(),
        ));
  }
}
