import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:grocery_shop_app/features/wishlist/domain/usecases/add_to_wishlist.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Home / Deals
import '../../core/network/api_client.dart';
import '../../features/Home/data/repositories/deal_product_repository_impl.dart';
import '../../features/Home/domain/repositories/deal_product_repository.dart';
import '../../features/Home/domain/usecases/get_deal_products.dart';
import '../../features/Home/presentation/manager/deal_product/deal_product_cubit.dart';

// Recommended
import '../../features/Home/data/repositories/recommended_repository_impl.dart';
import '../../features/Home/domain/repositories/recommended_repository.dart';
import '../../features/Home/domain/usecases/get_recommended_products.dart';
import '../../features/Home/presentation/manager/recommended/recommended_cubit.dart';

// Categories
import '../../features/auth/data/datasources/auth_local_data_source.dart';
import '../../features/auth/data/datasources/auth_local_data_source_impl.dart';
import '../../features/auth/data/datasources/auth_remote_data_source.dart';
import '../../features/auth/data/datasources/auth_remote_data_source_impl.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/auth/domain/usecases/login.dart';
import '../../features/auth/domain/usecases/refresh_token.dart';
import '../../features/auth/domain/usecases/register.dart';
import '../../features/auth/domain/usecases/request_password_reset.dart';
import '../../features/auth/domain/usecases/reset_password.dart';
import '../../features/auth/domain/usecases/verify_reset_code.dart';
import '../../features/auth/presentation/manager/auth_cubit.dart';
import '../../core/services/dio_auth_interceptor.dart';
import '../../features/categories/data/repositories/category_repository_impl.dart';
import '../../features/categories/domain/repositories/category_repository.dart';
import '../../features/categories/domain/usecases/get_categories.dart';
import '../../features/categories/presentation/manager/categories_cubit.dart';

// Products
import '../../features/checkout/domain/usecases/get_address_type.dart';
import '../../features/products/data/repositories/product_repository_impl.dart'
    as products_impl;
import '../../features/products/domain/repositories/product_repository.dart'
    as products_repo;
import '../../features/products/domain/usecases/get_products.dart'
    as products_uc;
import '../../features/products/presentation/manger/products_cubit.dart'
    as products_cubit;
import '../../features/products/data/datasources/product_local_data_source.dart'
    as products_ds;
import '../../features/products/data/models/product_model.dart'
    as products_model;
import '../../features/products/data/datasources/product_remote_data_source.dart'
    as products_remote_ds;

// Product Details & Similar
import '../../features/product_details/data/repositories/product_details_repository_impl.dart'
    as pd_impl;
import '../../features/product_details/domain/repositories/product_details_repository.dart'
    as pd_repo;
import '../../features/product_details/domain/usecases/get_product_details.dart'
    as pd_uc;
import '../../features/product_details/presentation/manager/product_details/product_details_cubit.dart'
    as pd_cubit;

import '../../features/product_details/data/repositories/similar_product_repository_imp.dart';
import '../../features/product_details/domain/repositories/similar_product_repository.dart';
import 'package:grocery_shop_app/features/product_details/domain/usecases/get_similar_product.dart';
import 'package:grocery_shop_app/features/product_details/presentation/manager/similar_product/similar_product_cubit.dart';

// Cart
import '../../features/cart/data/repositories/cart_repository_impl.dart'
    as cart_impl;
import '../../features/cart/domain/repositories/cart_repository.dart'
    as cart_repo;
import '../../features/cart/domain/usecases/get_cart.dart' as cart_get_uc;
import '../../features/cart/domain/usecases/add_to_cart.dart' as cart_add_uc;
import '../../features/cart/domain/usecases/remove_from_cart.dart'
    as cart_remove_uc;
import '../../features/cart/domain/usecases/update_quantity.dart'
    as cart_update_uc;
import '../../features/cart/domain/usecases/clear_cart_usecase.dart'
    as cart_clear_uc;
import '../../features/cart/presentation/manager/cart_cubit.dart' as cart_cubit;
import '../../features/cart/data/datasources/cart_local_data_source.dart'
    as cart_ds;
import '../../features/cart/data/datasources/cart_remote_data_source.dart'
    as cart_remote;

// Checkout
import '../../features/checkout/data/address_repository_impl.dart';
import '../../features/checkout/domain/repositories/address_repository.dart';
import '../../features/checkout/domain/usecases/get_addresses.dart';
import '../../features/checkout/domain/usecases/add_address.dart';
import '../../features/checkout/domain/usecases/update_address.dart';
import '../../features/checkout/domain/usecases/set_default_address.dart';
import '../../features/checkout/domain/usecases/delete_address.dart';
import '../../features/checkout/presentation/manager/checkout_cubit.dart';

// Payment
import '../../features/payment/data/repositories/mock_payment_repository.dart';
import '../../features/payment/domain/repositories/payment_repository.dart';
import '../../features/payment/domain/usecase/tokenize_and_pay.dart';
import '../../features/payment/presentation/manager/payment_cubit/payment_cubit.dart';

// Search
import '../../features/search/domain/usecases/clear_search_history.dart';
import '../../features/search/domain/usecases/remove_search_history_item.dart';

// ... (existing imports)

// Wishlist
import '../../features/wishlist/data/datasources/wishlist_local_data_source.dart';
import '../../features/wishlist/data/datasources/wishlist_local_data_source_impl.dart';
import '../../features/wishlist/data/repositories/wishlist_repository_impl.dart';
import '../../features/wishlist/domain/repositories/wishlist_repository.dart';
import '../../features/wishlist/domain/usecases/get_wishlist.dart';
import '../../features/wishlist/domain/usecases/remove_from_wishlist.dart';
import '../../features/wishlist/domain/usecases/toggle_favorite.dart';
import '../../features/wishlist/presentation/manager/cubit/wishlist_cubit.dart';

// Orders
import '../../features/orders/data/repositories/order_repository_impl.dart';
import '../../features/orders/domain/repositories/order_repository.dart';
import '../../features/orders/domain/usecases/get_orders.dart';
import '../../features/orders/domain/usecases/create_orders_usecase.dart'
    as order_create_uc;
import '../../features/orders/presentation/manager/orders_cubit.dart';
import '../../features/orders/data/datasources/order_local_data_source.dart'
    as order_local;
import '../../features/orders/data/datasources/order_remote_data_source.dart'
    as order_remote;

// Track Order
import '../../features/track_order/data/repositories/track_order_repository_impl.dart';
import '../../features/track_order/domain/repositories/track_order_repository.dart';
import '../../features/track_order/domain/usecases/get_track_order.dart';
import '../../features/track_order/presentation/manager/track_order_cubit.dart';
import '../../features/track_order/data/datasources/track_order_remote_data_source.dart';

// Search
import '../../features/search/data/datasources/search_local_data_source.dart';
import '../../features/search/data/datasources/search_remote_data_source.dart';
import '../../features/search/data/repositories/search_repository_impl.dart';
import '../../features/search/domain/repositories/search_repository.dart';
import '../../features/search/domain/usecases/get_search_suggestions.dart';
import '../../features/search/domain/usecases/search_products.dart';
import '../../features/search/presentation/manager/search_cubit.dart';

// // Auth
// import '../../features/auth/di/auth_module.dart' show initAuthModule;
// import '../env/app_config.dart';

// ...

final sl = GetIt.instance;

Future<void> init() async {
  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  if (!sl.isRegistered<SharedPreferences>()) {
    sl.registerLazySingleton(() => sharedPreferences);
  }
  if (!sl.isRegistered<Dio>()) {
    sl.registerLazySingleton(() => Dio());
  }
  // Initialize Hive Box if needed, or assume it's done in main.
  // For SearchLocalDataSource, we need a Box.
  // Ideally, openBox happens in main, but we can register it here.
  await Hive.initFlutter();
  if (!Hive.isBoxOpen('search_cache')) {
    await Hive.openBox<dynamic>('search_cache');
  }
  if (!sl.isRegistered<Box<dynamic>>()) {
    sl.registerLazySingleton<Box<dynamic>>(() => Hive.box('search_cache'));
  }

  // -----------------------------
  // Deal Product
  // -----------------------------
  if (!sl.isRegistered<DealProductRepository>()) {
    sl.registerLazySingleton<DealProductRepository>(
        () => DealProductRepositoryImpl());
  }
  if (!sl.isRegistered<GetDealProductsUseCase>()) {
    sl.registerLazySingleton(() => GetDealProductsUseCase(sl()));
  }
  if (!sl.isRegistered<DealProductCubit>()) {
    sl.registerFactory(() => DealProductCubit(sl()));
  }

  // -----------------------------
  // Recommended
  // -----------------------------
  if (!sl.isRegistered<RecommendedRepository>()) {
    sl.registerLazySingleton<RecommendedRepository>(
        () => RecommendedRepositoryImpl());
  }
  if (!sl.isRegistered<GetRecommendedProducts>()) {
    sl.registerLazySingleton(() => GetRecommendedProducts(sl()));
  }
  if (!sl.isRegistered<RecommendedCubit>()) {
    sl.registerFactory(() => RecommendedCubit(sl()));
  }

  // -----------------------------
  // Categories
  // -----------------------------
  if (!sl.isRegistered<CategoryRepository>()) {
    sl.registerLazySingleton<CategoryRepository>(
        () => CategoryRepositoryImpl());
  }
  if (!sl.isRegistered<GetCategories>()) {
    sl.registerLazySingleton(() => GetCategories(sl()));
  }
  if (!sl.isRegistered<CategoriesCubit>()) {
    sl.registerFactory(() => CategoriesCubit(sl()));
  }

  // -----------------------------
  // Products
  // -----------------------------
  if (!Hive.isAdapterRegistered(1)) {
    Hive.registerAdapter(products_model.ProductModelAdapter());
  }
  if (!Hive.isBoxOpen('product_cache')) {
    await Hive.openBox<dynamic>('product_cache');
  }

  if (!sl.isRegistered<products_ds.ProductLocalDataSource>()) {
    sl.registerLazySingleton<products_ds.ProductLocalDataSource>(() =>
        products_ds.ProductLocalDataSourceImpl(Hive.box('product_cache')));
  }

  if (!sl.isRegistered<products_remote_ds.ProductRemoteDataSource>()) {
    sl.registerLazySingleton<products_remote_ds.ProductRemoteDataSource>(
        () => products_remote_ds.ProductRemoteDataSourceImpl());
  }

  if (!sl.isRegistered<products_repo.ProductRepository>()) {
    sl.registerLazySingleton<products_repo.ProductRepository>(
        () => products_impl.ProductRepositoryImpl(
              localDataSource: sl(),
              remoteDataSource: sl(),
            ));
  }
  if (!sl.isRegistered<products_uc.GetProducts>()) {
    sl.registerLazySingleton(() => products_uc.GetProducts(sl()));
  }
  if (!sl.isRegistered<products_cubit.ProductsCubit>()) {
    sl.registerFactory(() => products_cubit.ProductsCubit(sl()));
  }

  // -----------------------------
  // Product Details
  // -----------------------------
  if (!sl.isRegistered<pd_repo.ProductDetailsRepository>()) {
    sl.registerLazySingleton<pd_repo.ProductDetailsRepository>(
        () => pd_impl.ProductDetailsRepositoryImpl(sl()));
  }
  if (!sl.isRegistered<pd_uc.GetProductDetails>()) {
    sl.registerLazySingleton(() => pd_uc.GetProductDetails(sl()));
  }
  if (!sl.isRegistered<pd_cubit.ProductDetailsCubit>()) {
    sl.registerFactory(() => pd_cubit.ProductDetailsCubit(sl()));
  }

  // -----------------------------
  // Similar Product
  // -----------------------------
  if (!sl.isRegistered<SimilarProductRepository>()) {
    sl.registerLazySingleton<SimilarProductRepository>(
        () => SimilarProductRepositoryImpl(sl()));
  }
  if (!sl.isRegistered<GetSimilarProduct>()) {
    sl.registerLazySingleton(() => GetSimilarProduct(sl()));
  }
  if (!sl.isRegistered<SimilarProductCubit>()) {
    sl.registerFactory(() => SimilarProductCubit(getSimilarProduct: sl()));
  }

  // -----------------------------
  // Cart
  // -----------------------------
  // -----------------------------
  // Cart
  // -----------------------------
  if (!Hive.isBoxOpen('cached_cart')) {
    await Hive.openBox<String>('cached_cart');
  }
  if (!sl.isRegistered<cart_ds.CartLocalDataSource>()) {
    sl.registerLazySingleton<cart_ds.CartLocalDataSource>(
        () => cart_ds.CartLocalDataSourceImpl(box: Hive.box('cached_cart')));
  }
  if (!sl.isRegistered<cart_remote.CartRemoteDataSource>()) {
    sl.registerLazySingleton<cart_remote.CartRemoteDataSource>(
        () => cart_remote.CartRemoteDataSourceImpl());
  }

  if (!sl.isRegistered<cart_repo.CartRepository>()) {
    sl.registerLazySingleton<cart_repo.CartRepository>(
        () => cart_impl.CartRepositoryImpl(
              localDataSource: sl(),
              remoteDataSource: sl(),
            ));
  }
  if (!sl.isRegistered<cart_get_uc.GetCartUseCase>()) {
    sl.registerLazySingleton(() => cart_get_uc.GetCartUseCase(sl()));
  }
  if (!sl.isRegistered<cart_add_uc.AddToCartUseCase>()) {
    sl.registerLazySingleton(() => cart_add_uc.AddToCartUseCase(sl()));
  }
  if (!sl.isRegistered<cart_remove_uc.RemoveFromCartUseCase>()) {
    sl.registerLazySingleton(() => cart_remove_uc.RemoveFromCartUseCase(sl()));
  }
  if (!sl.isRegistered<cart_update_uc.UpdateQuantityUseCase>()) {
    sl.registerLazySingleton(() => cart_update_uc.UpdateQuantityUseCase(sl()));
  }
  if (!sl.isRegistered<cart_clear_uc.ClearCartUseCase>()) {
    sl.registerLazySingleton(() => cart_clear_uc.ClearCartUseCase(sl()));
  }
  if (!sl.isRegistered<cart_cubit.CartCubit>()) {
    sl.registerFactory(() => cart_cubit.CartCubit(
          getCartUsecase: sl(),
          addToCartUsecase: sl(),
          clearCartUsecase: sl(),
          removeFromCartUsecase: sl(),
          updateQuantityUsecase: sl(),
        ));
  }

  // ... (Checkout) ...

  // -----------------------------
  // Checkout
  // -----------------------------
  if (!sl.isRegistered<AddressRepository>()) {
    sl.registerLazySingleton<AddressRepository>(
        () => InMemoryAddressRepository());
  }
  if (!sl.isRegistered<GetAddressesUseCase>()) {
    sl.registerLazySingleton(() => GetAddressesUseCase(sl()));
  }
  if (!sl.isRegistered<GetAddressTypeUseCase>()) {
    sl.registerLazySingleton(() => GetAddressTypeUseCase(sl()));
  }
  if (!sl.isRegistered<AddAddressUseCase>()) {
    sl.registerLazySingleton(() => AddAddressUseCase(sl()));
  }
  if (!sl.isRegistered<UpdateAddressUseCase>()) {
    sl.registerLazySingleton(() => UpdateAddressUseCase(sl()));
  }
  if (!sl.isRegistered<SetDefaultAddressUseCase>()) {
    sl.registerLazySingleton(() => SetDefaultAddressUseCase(sl()));
  }
  if (!sl.isRegistered<DeleteAddressUseCase>()) {
    sl.registerLazySingleton(() => DeleteAddressUseCase(sl()));
  }
  if (!sl.isRegistered<CheckoutCubit>()) {
    sl.registerFactory(() => CheckoutCubit(
          getAddresses: sl(),
          getAddressType: sl(),
          addAddress: sl(),
          updateAddress: sl(),
          setDefaultAddress: sl(),
          deleteAddress: sl(),
        ));
  }

  // -----------------------------
  // Payment
  // -----------------------------
  if (!sl.isRegistered<PaymentRepository>()) {
    sl.registerLazySingleton<PaymentRepository>(() => MockPaymentRepository());
  }
  if (!sl.isRegistered<TokenizeAndPayUseCase>()) {
    sl.registerLazySingleton(() => TokenizeAndPayUseCase(sl()));
  }
  if (!sl.isRegistered<PaymentCubit>()) {
    sl.registerFactory(() => PaymentCubit(
          useCase: sl(),
          createOrderUseCase: sl(),
          clearCartUseCase: sl(),
        ));
  }

  // ... (Search) ...
  // -----------------------------
  // Search
  // -----------------------------

  // Use Cases
  if (!sl.isRegistered<GetSearchSuggestions>()) {
    sl.registerLazySingleton(() => GetSearchSuggestions(sl()));
  }
  if (!sl.isRegistered<SearchProducts>()) {
    sl.registerLazySingleton(() => SearchProducts(sl()));
  }
  if (!sl.isRegistered<ClearSearchHistory>()) {
    sl.registerLazySingleton(() => ClearSearchHistory(sl()));
  }
  if (!sl.isRegistered<RemoveSearchHistoryItem>()) {
    sl.registerLazySingleton(() => RemoveSearchHistoryItem(sl()));
  }

  // Repository
  if (!sl.isRegistered<SearchRepository>()) {
    sl.registerLazySingleton<SearchRepository>(
      () => SearchRepositoryImpl(
        productRepository: sl<products_repo.ProductRepository>(),
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
        getSearchSuggestions: sl<GetSearchSuggestions>(),
        searchProducts: sl<SearchProducts>(),
        clearSearchHistory: sl<ClearSearchHistory>(),
        removeSearchHistoryItem: sl<RemoveSearchHistoryItem>(),
      ),
    );
  }

  // -----------------------------
  // Wishlist
  // -----------------------------

  if (!sl.isRegistered<WishlistLocalDataSource>()) {
    sl.registerLazySingleton<WishlistLocalDataSource>(
      () => WishlistLocalDataSourceImpl(sl<Box<dynamic>>()),
    );
  }
  if (!sl.isRegistered<WishlistRepository>()) {
    sl.registerLazySingleton<WishlistRepository>(() =>
        WishlistRepositoryImpl(localDataSource: sl<WishlistLocalDataSource>()));
  }
  if (!sl.isRegistered<GetWishlist>()) {
    sl.registerLazySingleton<GetWishlist>(
        () => GetWishlist(sl<WishlistRepository>()));
  }
  if (!sl.isRegistered<RemoveFromWishlist>()) {
    sl.registerLazySingleton<RemoveFromWishlist>(
        () => RemoveFromWishlist(sl<WishlistRepository>()));
  }
  if (!sl.isRegistered<AddToWishlist>()) {
    sl.registerLazySingleton<AddToWishlist>(
        () => AddToWishlist(sl<WishlistRepository>()));
  }
  if (!sl.isRegistered<ToggleFavorite>()) {
    sl.registerLazySingleton<ToggleFavorite>(
        () => ToggleFavorite(sl<WishlistRepository>()));
  }
  if (!sl.isRegistered<WishlistCubit>()) {
    sl.registerFactory<WishlistCubit>(() => WishlistCubit(
          getWishlist: sl<GetWishlist>(),
          removeFromWishlist: sl<RemoveFromWishlist>(),
          addToWishlist: sl<AddToWishlist>(),
          toggleFavorite: sl<ToggleFavorite>(),
        ));
  }
  // -----------------------------
  // Orders
  // -----------------------------
  if (!Hive.isBoxOpen('cached_orders')) {
    await Hive.openBox<String>('cached_orders');
  }
  if (!sl.isRegistered<order_local.OrderLocalDataSource>()) {
    sl.registerLazySingleton<order_local.OrderLocalDataSource>(() =>
        order_local.OrderLocalDataSourceImpl(box: Hive.box('cached_orders')));
  }
  if (!sl.isRegistered<order_remote.OrderRemoteDataSource>()) {
    sl.registerLazySingleton<order_remote.OrderRemoteDataSource>(
        () => order_remote.OrderRemoteDataSourceImpl());
  }

  if (!sl.isRegistered<OrderRepository>()) {
    sl.registerLazySingleton<OrderRepository>(() => OrderRepositoryImpl(
          localDataSource: sl(),
          remoteDataSource: sl(),
        ));
  }
  if (!sl.isRegistered<GetOrders>()) {
    sl.registerLazySingleton<GetOrders>(() => GetOrders(sl<OrderRepository>()));
  }
  if (!sl.isRegistered<order_create_uc.CreateOrderUseCase>()) {
    sl.registerLazySingleton(() => order_create_uc.CreateOrderUseCase(sl()));
  }
  if (!sl.isRegistered<OrdersCubit>()) {
    sl.registerFactory<OrdersCubit>(
        () => OrdersCubit(getOrdersUseCase: sl<GetOrders>()));
  }

  // -----------------------------
  // Track Order
  // -----------------------------
  if (!sl.isRegistered<TrackOrderRemoteDataSource>()) {
    sl.registerLazySingleton<TrackOrderRemoteDataSource>(
        () => TrackOrderRemoteDataSourceImpl());
  }

  if (!sl.isRegistered<TrackOrderRepository>()) {
    sl.registerLazySingleton<TrackOrderRepository>(
        () => TrackOrderRepositoryImpl(remoteDataSource: sl()));
  }

  if (!sl.isRegistered<GetTrackOrder>()) {
    sl.registerLazySingleton<GetTrackOrder>(
        () => GetTrackOrder(sl<TrackOrderRepository>()));
  }
  if (!sl.isRegistered<TrackOrderCubit>()) {
    sl.registerFactory<TrackOrderCubit>(
        () => TrackOrderCubit(getTrackOrderUseCase: sl<GetTrackOrder>()));
  }

  // -----------------------------
  // Auth
  // -----------------------------

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
      () => AuthRemoteDataSourceImpl(client: sl<Dio>(instanceName: 'authDio')),
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
  if (!sl.isRegistered<Login>()) {
    sl.registerLazySingleton<Login>(() => Login(sl<AuthRepository>()));
  }

  if (!sl.isRegistered<Register>()) {
    sl.registerLazySingleton<Register>(() => Register(sl<AuthRepository>()));
  }

  if (!sl.isRegistered<RequestPasswordReset>()) {
    sl.registerLazySingleton<RequestPasswordReset>(
        () => RequestPasswordReset(sl<AuthRepository>()));
  }

  if (!sl.isRegistered<VerifyResetCode>()) {
    sl.registerLazySingleton<VerifyResetCode>(
        () => VerifyResetCode(sl<AuthRepository>()));
  }

  if (!sl.isRegistered<ResetPassword>()) {
    sl.registerLazySingleton<ResetPassword>(
        () => ResetPassword(sl<AuthRepository>()));
  }

  if (!sl.isRegistered<RefreshToken>()) {
    sl.registerLazySingleton<RefreshToken>(
        () => RefreshToken(sl<AuthRepository>()));
  }

  // Cubit
  if (!sl.isRegistered<AuthCubit>()) {
    sl.registerFactory<AuthCubit>(
      () => AuthCubit(
        loginUseCase: sl<Login>(),
        registerUseCase: sl<Register>(),
        requestPasswordResetUseCase: sl<RequestPasswordReset>(),
        verifyResetCodeUseCase: sl<VerifyResetCode>(),
        resetPasswordUseCase: sl<ResetPassword>(),
        refreshTokenUseCase: sl<RefreshToken>(),
        repository: sl<AuthRepository>(),
      ),
    );
  }
}

/// إعادة تهيئة التبعيات (ينفّذ reset ثم init)
Future<void> reset() async {
  await sl.reset();
  await init();
}

/// دوال مساعدة للوصول للتبعيات في كامل المشروع
bool isRegistered<T extends Object>() => sl.isRegistered<T>();
T get<T extends Object>() => sl.get<T>();
void registerSingleton<T extends Object>(T instance) =>
    sl.registerSingleton<T>(instance);
void registerLazySingleton<T extends Object>(T Function() factory) =>
    sl.registerLazySingleton<T>(factory);
void registerFactory<T extends Object>(T Function() factory) =>
    sl.registerFactory<T>(factory);
void unregister<T extends Object>() => sl.unregister<T>();
