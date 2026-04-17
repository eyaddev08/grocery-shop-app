import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../data/datasources/cart_local_data_source.dart';
import '../data/datasources/cart_remote_data_source.dart';
import '../data/repositories/cart_repository_impl.dart';
import '../domain/repositories/cart_repository.dart';
import '../domain/usecases/add_to_cart.dart';
import '../domain/usecases/clear_cart_usecase.dart';
import '../domain/usecases/get_cart.dart';
import '../domain/usecases/remove_from_cart.dart';
import '../domain/usecases/update_quantity.dart';
import '../presentation/manager/cart_cubit.dart';

class CartModule {
  static Future<void> init(GetIt sl) async {
    // Cart cache box (dynamic)
    if (!Hive.isBoxOpen('cached_cart')) {
      await Hive.openBox<String>('cached_cart');
    }

    // Data Sources
    if (!sl.isRegistered<CartLocalDataSource>()) {
      sl.registerLazySingleton<CartLocalDataSource>(
          () => CartLocalDataSourceImpl(box: Hive.box('cached_cart')));
    }
    if (!sl.isRegistered<CartRemoteDataSource>()) {
      sl.registerLazySingleton<CartRemoteDataSource>(
          () => CartRemoteDataSourceImpl(dio: sl<Dio>()));
    }

    // Repository
    if (!sl.isRegistered<CartRepository>()) {
      sl.registerLazySingleton<CartRepository>(() => CartRepositoryImpl(
            localDataSource: sl(),
            remoteDataSource: sl(),
            networkInfo: sl(),
          ));
    }

    // Use Cases
    if (!sl.isRegistered<GetCartUseCase>()) {
      sl.registerLazySingleton(() => GetCartUseCase(sl()));
    }
    if (!sl.isRegistered<AddToCartUseCase>()) {
      sl.registerLazySingleton(() => AddToCartUseCase(sl()));
    }
    if (!sl.isRegistered<RemoveFromCartUseCase>()) {
      sl.registerLazySingleton(() => RemoveFromCartUseCase(sl()));
    }
    if (!sl.isRegistered<UpdateQuantityUseCase>()) {
      sl.registerLazySingleton(() => UpdateQuantityUseCase(sl()));
    }
    if (!sl.isRegistered<ClearCartUseCase>()) {
      sl.registerLazySingleton(() => ClearCartUseCase(sl()));
    }

    // Cubit
    if (!sl.isRegistered<CartCubit>()) {
      sl.registerFactory(() => CartCubit(
            getCartUsecase: sl(),
            addToCartUsecase: sl(),
            clearCartUsecase: sl(),
            removeFromCartUsecase: sl(),
            updateQuantityUsecase: sl(),
          ));
    }
  }
}
