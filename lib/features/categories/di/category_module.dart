import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';

import '../data/datasources/category_local_data_source.dart';
import '../data/datasources/category_remote_data_source.dart';
import '../data/models/category_model.dart';
import '../data/repositories/category_repository_impl.dart';
import '../domain/repositories/category_repository.dart';
import '../domain/usecases/get_categories.dart';
import '../presentation/manager/categories_cubit.dart';

class CategoryModule {
  static Future<void> init(GetIt sl) async {
    // Category cache box (dynamic)
    if (!Hive.isAdapterRegistered(5)) {
      Hive.registerAdapter(CategoryModelAdapter());
    }
    if (!Hive.isBoxOpen('category_cache')) {
      await Hive.openBox<dynamic>('category_cache');
    }
    // Data Sources
    if (!sl.isRegistered<CategoryLocalDataSource>()) {
      sl.registerLazySingleton<CategoryLocalDataSource>(
          () => CategoryLocalDataSourceImpl(
                Hive.box('category_cache'),
              ));
    }

    if (!sl.isRegistered<CategoryRemoteDataSource>()) {
      sl.registerLazySingleton<CategoryRemoteDataSource>(
          () => CategoryRemoteDataSourceImpl());
    }

    // Repository
    if (!sl.isRegistered<CategoryRepository>()) {
      sl.registerLazySingleton<CategoryRepository>(() => CategoryRepositoryImpl(
            localDataSource: sl(),
            remoteDataSource: sl(),
            networkInfo: sl(),
          ));
    }

    // Use Cases
    if (!sl.isRegistered<GetCategoriesUseCase>()) {
      sl.registerLazySingleton(() => GetCategoriesUseCase(sl()));
    }

    // Cubit
    if (!sl.isRegistered<CategoriesCubit>()) {
      sl.registerFactory(() => CategoriesCubit(sl()));
    }
  }
}
