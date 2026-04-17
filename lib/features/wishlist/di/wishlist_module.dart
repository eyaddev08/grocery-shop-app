import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:grocery_shop_app/core/network/network_info.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../data/datasources/wishlist_local_data_source_impl.dart';
import '../data/datasources/wishlist_remote_data_source_impl.dart';
import '../data/models/wishlist_product_model.dart';
import '../data/repositories/wishlist_repository_impl.dart';
import '../domain/repositories/wishlist_repository.dart';
import '../domain/usecases/add_to_wishlist.dart';
import '../domain/usecases/get_wishlist.dart';
import '../domain/usecases/remove_from_wishlist.dart';
import '../domain/usecases/toggle_favorite.dart';
import '../presentation/manager/cubit/wishlist_cubit.dart';

class WishlistModule {
  static Future<void> init(GetIt sl) async {
    if (!Hive.isAdapterRegistered(4)) {
      Hive.registerAdapter(WishlistProductModelAdapter());
    }
    if (!Hive.isBoxOpen('wishlist_products')) {
      await Hive.openBox<WishlistProductModel>('wishlist_products');
    }

    // Data Source
    if (!sl.isRegistered<WishlistLocalDataSource>()) {
      sl.registerLazySingleton<WishlistLocalDataSource>(
        () => WishlistLocalDataSourceImpl(Hive.box<WishlistProductModel>('wishlist_products')),
      );
    }
    if (!sl.isRegistered<WishlistRemoteDataSource>()) {
      sl.registerLazySingleton<WishlistRemoteDataSource>(
        () => WishlistRemoteDataSourceImpl(client: sl<Dio>()),
      );
    }

    // Repository
    if (!sl.isRegistered<WishlistRepository>()) {
      sl.registerLazySingleton<WishlistRepository>(() => WishlistRepositoryImpl(
          remoteDataSource: sl<WishlistRemoteDataSource>(),
          localDataSource: sl<WishlistLocalDataSource>(),
          networkInfo: sl<NetworkInfo>()));
    }

    // Use Case
    if (!sl.isRegistered<GetWishlistUseCase>()) {
      sl.registerLazySingleton<GetWishlistUseCase>(
          () => GetWishlistUseCase(sl<WishlistRepository>()));
    }
    if (!sl.isRegistered<RemoveFromWishlistUseCase>()) {
      sl.registerLazySingleton<RemoveFromWishlistUseCase>(
          () => RemoveFromWishlistUseCase(sl<WishlistRepository>()));
    }
    if (!sl.isRegistered<AddToWishlistUseCase>()) {
      sl.registerLazySingleton<AddToWishlistUseCase>(
          () => AddToWishlistUseCase(sl<WishlistRepository>()));
    }
    if (!sl.isRegistered<ToggleFavoriteUseCase>()) {
      sl.registerLazySingleton<ToggleFavoriteUseCase>(
          () => ToggleFavoriteUseCase(sl<WishlistRepository>()));
    }

    // Cubit
    if (!sl.isRegistered<WishlistCubit>()) {
      sl.registerFactory<WishlistCubit>(() => WishlistCubit(
            getWishlist: sl<GetWishlistUseCase>(),
            removeFromWishlist: sl<RemoveFromWishlistUseCase>(),
            addToWishlist: sl<AddToWishlistUseCase>(),
            toggleFavorite: sl<ToggleFavoriteUseCase>(),
          ));
    }
  }
}
