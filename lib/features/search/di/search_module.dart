import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';

import '../../products/domain/repositories/product_repository.dart';
import '../data/datasources/search_local_data_source.dart';
import '../data/datasources/search_remote_data_source.dart';
import '../data/repositories/search_repository_impl.dart';
import '../domain/repositories/search_repository.dart';
import '../domain/usecases/clear_search_history.dart';
import '../domain/usecases/get_search_suggestions.dart';
import '../domain/usecases/remove_search_history_item.dart';
import '../domain/usecases/search_products.dart';
import '../presentation/manager/search_cubit.dart';

class SearchModule {
  static Future<void> init(GetIt sl) async{
    // Search cache box (dynamic)
  if (!Hive.isBoxOpen('search_cache')) {
    await Hive.openBox<dynamic>('search_cache');
  }
  if (!sl.isRegistered<Box<dynamic>>()) {
    sl.registerLazySingleton<Box<dynamic>>(() => Hive.box('search_cache'));
  }
  
    // Use Cases
  if (!sl.isRegistered<GetSearchSuggestionsUseCase>()) {
    sl.registerLazySingleton(() => GetSearchSuggestionsUseCase(
          searchRepository: sl<SearchRepository>(),
          productRepository: sl<ProductRepository>(),
        ));
  }
  if (!sl.isRegistered<SearchProducts>()) {
    sl.registerLazySingleton(() => SearchProducts(
          searchRepository: sl<SearchRepository>(),
          productRepository: sl<ProductRepository>(),
        ));
  }
  if (!sl.isRegistered<ClearSearchHistoryUseCase>()) {
    sl.registerLazySingleton(() => ClearSearchHistoryUseCase(sl()));
  }
  if (!sl.isRegistered<RemoveSearchHistoryItemUseCase>()) {
    sl.registerLazySingleton(() => RemoveSearchHistoryItemUseCase(sl()));
  }
  // Repository
  if (!sl.isRegistered<SearchRepository>()) {
    sl.registerLazySingleton<SearchRepository>(
      () => SearchRepositoryImpl(
        remoteDataSource: sl<SearchRemoteDataSource>(),
        localDataSource: sl<SearchLocalDataSource>(),
      ),
    );
  }
  // Data Sources
  if (!sl.isRegistered<SearchRemoteDataSource>()) {
    sl.registerLazySingleton<SearchRemoteDataSource>(
      () => SearchRemoteDataSourceImpl(client: sl<Dio>()),
    );
  }
  if (!sl.isRegistered<SearchLocalDataSource>()) {
    sl.registerLazySingleton<SearchLocalDataSource>(
      () => SearchLocalDataSourceImpl(sl<Box<dynamic>>()),
    );
  }
  // Cubit
  if (!sl.isRegistered<SearchCubit>()) {
    sl.registerFactory(
      () => SearchCubit(
        getSearchSuggestions: sl<GetSearchSuggestionsUseCase>(),
        searchProducts: sl<SearchProducts>(),
        clearSearchHistory: sl<ClearSearchHistoryUseCase>(),
        removeSearchHistoryItem: sl<RemoveSearchHistoryItemUseCase>(),
      ),
    );
  }
  }
}
