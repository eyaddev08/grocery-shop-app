import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../data/datasources/product_local_data_source.dart';
import '../data/datasources/product_remote_data_source.dart';
import '../data/models/product_model.dart';
import '../data/repositories/product_repository_impl.dart';
import '../domain/repositories/product_repository.dart';
import '../domain/usecases/get_deals_products.dart';
import '../domain/usecases/get_products.dart';
import '../domain/usecases/get_recommended_products.dart';
import '../presentation/manager/product_cubit/product_cubit.dart';

class ProductModule {
  static Future<void> init(GetIt sl) async {
    // ---- 1. External (Hive & Network) ----
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(ProductModelAdapter());
    }
    if (!Hive.isBoxOpen('product_cache')) {
      await Hive.openBox<dynamic>('product_cache');
    }

    // ---- 2. Data Sources ----
    sl.registerLazySingleton<ProductLocalDataSource>(
      () => ProductLocalDataSourceImpl(Hive.box('product_cache')),
    );

    sl.registerLazySingleton<ProductRemoteDataSource>(
      () => ProductRemoteDataSourceImpl(),
    );

    // ---- 3. Repositories ----
    sl.registerLazySingleton<ProductRepository>(
      () => ProductRepositoryImpl(
        localDataSource: sl(),
        remoteDataSource: sl(),
        networkInfo: sl(),
      ),
    );

    // ---- 4. Use Cases ----
    sl.registerLazySingleton(() => GetProductsUseCase(sl()));
    sl.registerLazySingleton(() => GetDealsProductsUseCase(sl()));
    sl.registerLazySingleton(() => GetRecommendedProductsUseCase(sl()));

    // ---- 5. Presentation (Bloc/Cubit) ----
    sl.registerFactory(
      () => ProductCubit(
        getProductsUseCase: sl(),
        getDealsUseCase: sl(),
        getRecommendedUseCase: sl(),
      ),
    );
  }
}
