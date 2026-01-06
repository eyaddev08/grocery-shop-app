import 'package:get_it/get_it.dart';
import 'package:grocery_shop_app/features/product_details/domain/usecases/get_similar_product.dart';
import 'package:grocery_shop_app/features/product_details/presentation/manager/similar_product/similar_product_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

// import '../../features/Home/data/repositories/deal_product_repository_impl.dart';
import '../../features/Home/data/repositories/deal_product_repository_impl.dart';
// import '../../features/Home/domain/usecases/get_deals_products_usecase.dart';
import '../../features/Home/domain/usecases/get_deal_products.dart';

// Services
// import 'package:grocery_shop_app/core/services/api_service.dart';
// import 'package:grocery_shop_app/core/services/auth_service.dart';
// import 'package:grocery_shop_app/core/services/cart_service.dart';
// import 'package:grocery_shop_app/core/services/storage_service.dart';
// import 'package:grocery_shop_app/core/services/notification_service.dart';

// Repositories
// import 'package:grocery_shop_app/features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/Home/domain/repositories/deal_product_repository.dart';
import '../../features/Home/data/repositories/recommended_repository_impl.dart';
import '../../features/Home/domain/repositories/recommended_repository.dart';
import '../../features/Home/domain/usecases/get_recommended_products.dart';
import '../../features/Home/presentation/manager/deal_product/deal_product_cubit.dart';
import '../../features/Home/presentation/manager/recommended/recommended_cubit.dart';
import '../../features/categories/data/repositories/category_repository_impl.dart';
import '../../features/categories/domain/repositories/category_repository.dart';
import '../../features/categories/domain/usecases/get_categories.dart';
import '../../features/categories/presentation/manger/categories_cubit.dart';
import '../../features/checkout/data/address_repository_impl.dart';
import '../../features/checkout/domain/repositories/address_repository.dart';
import '../../features/checkout/domain/usecases/add_address.dart';
import '../../features/checkout/domain/usecases/delete_address.dart';
import '../../features/checkout/domain/usecases/get_addresses.dart';
import '../../features/checkout/domain/usecases/set_default_address.dart';
import '../../features/checkout/domain/usecases/update_address.dart';
import '../../features/checkout/presentation/manager/checkout_cubit.dart';

import '../../features/payment/data/repositories/mock_payment_repository.dart';
import '../../features/payment/domain/repositories/payment_repository.dart';
import '../../features/payment/domain/usecase/tokenize_and_pay.dart';
import '../../features/payment/presentation/manager/payment_cubit/payment_cubit.dart';
import '../../features/product_details/data/repositories/similar_product_repository_imp.dart';
import '../../features/product_details/domain/repositories/similar_product_repository.dart';
import '../../features/products/data/repositories/product_repository_impl.dart'
    as products_impl;
import '../../features/products/domain/repositories/product_repository.dart'
    as products_repo;
import '../../features/products/domain/usecases/get_products.dart'
    as products_uc;
import '../../features/products/presentation/manger/products_cubit.dart'
    as products_cubit;

import '../../features/product_details/data/repositories/product_details_repository_impl.dart'
    as pd_impl;
import '../../features/product_details/domain/repositories/product_details_repository.dart'
    as pd_repo;
import '../../features/product_details/domain/usecases/get_product_details.dart'
    as pd_uc;
import '../../features/product_details/presentation/manager/product_details/product_details_cubit.dart'
    as pd_cubit;
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
import '../../features/cart/presentation/manager/cart_cubit.dart' as cart_cubit;
import '../../features/wishlist/data/repositories/in_memory_wishlist_repository.dart';
import '../../features/wishlist/domain/repositories/wishlist_repository.dart';
import '../../features/wishlist/domain/usecases/get_wishlist.dart';
import '../../features/wishlist/domain/usecases/remove_from_wishlist.dart';
import '../../features/wishlist/presentation/manager/cubit/wishlist_cubit.dart';
import '../../features/orders/data/repositories/order_repository_impl.dart';
import '../../features/orders/domain/repositories/order_repository.dart';
import '../../features/orders/domain/usecases/get_orders.dart';
import '../../features/orders/presentation/manager/orders_cubit.dart';
import '../../features/track_order/data/repositories/track_order_repository_impl.dart';
import '../../features/track_order/domain/repositories/track_order_repository.dart';
import '../../features/track_order/domain/usecases/get_track_order.dart';
import '../../features/track_order/presentation/manager/track_order_cubit.dart';
// import 'package:grocery_shop_app/features/cart/data/repositories/cart_repository_impl.dart';

// Use Cases
// import 'package:grocery_shop_app/features/auth/domain/usecases/login_usecase.dart';
// import 'package:grocery_shop_app/features/auth/domain/usecases/register_usecase.dart';
// import 'package:grocery_shop_app/features/products/domain/usecases/get_products_usecase.dart';
// import 'package:grocery_shop_app/features/cart/domain/usecases/add_to_cart_usecase.dart';

// Blocs/Cubits
// import 'package:grocery_shop_app/features/auth/presentation/bloc/auth_bloc.dart';
// import 'package:grocery_shop_app/features/products/presentation/bloc/products_bloc.dart';
// import 'package:grocery_shop_app/features/cart/presentation/bloc/cart_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  if (!sl.isRegistered<SharedPreferences>()) {
    sl.registerLazySingleton(() => sharedPreferences);
  }
  // Services
  // sl.registerLazySingleton(() => ApiService());
  // sl.registerLazySingleton(() => AuthService(sl()));
  // sl.registerLazySingleton(() => CartService(sl()));
  // sl.registerLazySingleton(() => StorageService(sl()));
  // sl.registerLazySingleton(() => NotificationService());

  // Repositories
  // sl.registerLazySingleton(() => AuthRepositoryImpl(sl(), sl()));
  // sl.registerLazySingleton(() => ProductRepositoryImpl());
  if (!sl.isRegistered<DealProductRepository>()) {
    sl.registerLazySingleton<DealProductRepository>(
        () => DealProductRepositoryImpl());
  }

  // register usecase
  if (!sl.isRegistered<GetDealProductsUseCase>()) {
    sl.registerLazySingleton<GetDealProductsUseCase>(
        () => GetDealProductsUseCase(sl<DealProductRepository>()));
  }

  // recommended registrations
  if (!sl.isRegistered<RecommendedRepository>()) {
    sl.registerLazySingleton<RecommendedRepository>(
        () => RecommendedRepositoryImpl());
  }

  if (!sl.isRegistered<GetRecommendedProducts>()) {
    sl.registerLazySingleton<GetRecommendedProducts>(
        () => GetRecommendedProducts(sl<RecommendedRepository>()));
  }

  if (!sl.isRegistered<RecommendedCubit>()) {
    sl.registerFactory<RecommendedCubit>(
        () => RecommendedCubit(sl<GetRecommendedProducts>()));
  }

  // register cubit/bloc
  if (!sl.isRegistered<DealProductCubit>()) {
    sl.registerFactory<DealProductCubit>(
        () => DealProductCubit(sl<GetDealProductsUseCase>()));
  }

  // Categories registrations
  if (!sl.isRegistered<CategoryRepository>()) {
    sl.registerLazySingleton<CategoryRepository>(
        () => CategoryRepositoryImpl());
  }

  // Products registrations
  if (!sl.isRegistered<products_repo.ProductRepository>()) {
    sl.registerLazySingleton<products_repo.ProductRepository>(
        () => products_impl.ProductRepositoryImpl());
  }

  if (!sl.isRegistered<products_uc.GetProducts>()) {
    sl.registerLazySingleton<products_uc.GetProducts>(
        () => products_uc.GetProducts(sl<products_repo.ProductRepository>()));
  }

  if (!sl.isRegistered<products_cubit.ProductsCubit>()) {
    sl.registerFactory<products_cubit.ProductsCubit>(
        () => products_cubit.ProductsCubit(sl<products_uc.GetProducts>()));
  }

  // product details registrations
  if (!sl.isRegistered<pd_repo.ProductDetailsRepository>()) {
    sl.registerLazySingleton<pd_repo.ProductDetailsRepository>(() =>
        pd_impl.ProductDetailsRepositoryImpl(
            sl<products_repo.ProductRepository>()));
  }

  if (!sl.isRegistered<pd_uc.GetProductDetails>()) {
    sl.registerLazySingleton<pd_uc.GetProductDetails>(
        () => pd_uc.GetProductDetails(sl<pd_repo.ProductDetailsRepository>()));
  }

  if (!sl.isRegistered<pd_cubit.ProductDetailsCubit>()) {
    sl.registerFactory<pd_cubit.ProductDetailsCubit>(
        () => pd_cubit.ProductDetailsCubit( sl()));
  }

  // similar product registrations
  if (!sl.isRegistered<SimilarProductRepository>()) {
    sl.registerLazySingleton<SimilarProductRepository>(() =>
        SimilarProductRepositoryImpl( sl<products_repo.ProductRepository>()
          ));
  }

  if (!sl.isRegistered<GetSimilarProduct>()) {
    sl.registerLazySingleton<GetSimilarProduct>(
        () => GetSimilarProduct(sl<SimilarProductRepository>()));
  }

  if (!sl.isRegistered<SimilarProductCubit>()) {
    sl.registerFactory<SimilarProductCubit>(
        () => SimilarProductCubit(getSimilarProduct: sl<GetSimilarProduct>()));
  }

  // register categories usecase
  if (!sl.isRegistered<GetCategories>()) {
    sl.registerLazySingleton<GetCategories>(
        () => GetCategories(sl<CategoryRepository>()));
  }

  // register categories cubit
  if (!sl.isRegistered<CategoriesCubit>()) {
    sl.registerFactory<CategoriesCubit>(
        () => CategoriesCubit(sl<GetCategories>()));
  }

  // Cart registrations
  if (!sl.isRegistered<cart_repo.CartRepository>()) {
    sl.registerLazySingleton<cart_repo.CartRepository>(
        () => cart_impl.CartRepositoryImpl());
  }

  if (!sl.isRegistered<cart_get_uc.GetCart>()) {
    sl.registerLazySingleton<cart_get_uc.GetCart>(
        () => cart_get_uc.GetCart(sl<cart_repo.CartRepository>()));
  }

  if (!sl.isRegistered<cart_add_uc.AddToCart>()) {
    sl.registerLazySingleton<cart_add_uc.AddToCart>(
        () => cart_add_uc.AddToCart(sl<cart_repo.CartRepository>()));
  }

  if (!sl.isRegistered<cart_remove_uc.RemoveFromCart>()) {
    sl.registerLazySingleton<cart_remove_uc.RemoveFromCart>(
        () => cart_remove_uc.RemoveFromCart(sl<cart_repo.CartRepository>()));
  }

  if (!sl.isRegistered<cart_update_uc.UpdateQuantity>()) {
    sl.registerLazySingleton<cart_update_uc.UpdateQuantity>(
        () => cart_update_uc.UpdateQuantity(sl<cart_repo.CartRepository>()));
  }

  if (!sl.isRegistered<cart_cubit.CartCubit>()) {
    sl.registerFactory<cart_cubit.CartCubit>(() => cart_cubit.CartCubit(
        getCartUsecase: sl(),
        addToCartUsecase: sl(),
        removeFromCartUsecase: sl(),
        updateQuantityUsecase: sl()));
  }

  // Checkout registrations
  if (!sl.isRegistered<AddressRepository>()) {
    sl.registerLazySingleton<AddressRepository>(
        () => InMemoryAddressRepository());
  }

  if (!sl.isRegistered<GetAddressesUseCase>()) {
    sl.registerLazySingleton<GetAddressesUseCase>(
        () => GetAddressesUseCase(sl<AddressRepository>()));
  }
  if (!sl.isRegistered<AddAddressUseCase>()) {
    sl.registerLazySingleton<AddAddressUseCase>(
        () => AddAddressUseCase(sl<AddressRepository>()));
  }
  if (!sl.isRegistered<UpdateAddressUseCase>()) {
    sl.registerLazySingleton<UpdateAddressUseCase>(
        () => UpdateAddressUseCase(sl<AddressRepository>()));
  }
  if (!sl.isRegistered<SetDefaultAddressUseCase>()) {
    sl.registerLazySingleton<SetDefaultAddressUseCase>(
        () => SetDefaultAddressUseCase(sl<AddressRepository>()));
  }
  if (!sl.isRegistered<DeleteAddressUseCase>()) {
    sl.registerLazySingleton<DeleteAddressUseCase>(
        () => DeleteAddressUseCase(sl<AddressRepository>()));
  }

  if (!sl.isRegistered<CheckoutCubit>()) {
    sl.registerFactory<CheckoutCubit>(() => CheckoutCubit(
        getAddresses: sl(),
        addAddress: sl(),
        updateAddress: sl(),
        setDefaultAddress: sl(),
        deleteAddress: sl()));
  }
  // Payment registrations
  if (!sl.isRegistered<PaymentRepository>()) {
    sl.registerLazySingleton<PaymentRepository>(() => MockPaymentRepository());
  }

  if (!sl.isRegistered<TokenizeAndPayUseCase>()) {
    sl.registerLazySingleton<TokenizeAndPayUseCase>(
        () => TokenizeAndPayUseCase(sl<PaymentRepository>()));
  }

  if (!sl.isRegistered<PaymentCubit>()) {
    sl.registerFactory<PaymentCubit>(() => PaymentCubit(
          useCase: sl(),
        ));
  }
  if (!sl.isRegistered<WishlistRepository>()) {
    sl.registerLazySingleton<WishlistRepository>(
        () => InMemoryWishlistRepository());
  }

  if (!sl.isRegistered<GetWishlist>()) {
    sl.registerLazySingleton<GetWishlist>(
        () => GetWishlist(sl<WishlistRepository>()));
  }
  if (!sl.isRegistered<RemoveFromWishlist>()) {
    sl.registerLazySingleton<RemoveFromWishlist>(
        () => RemoveFromWishlist(sl<WishlistRepository>()));
  }

  if (!sl.isRegistered<WishlistCubit>()) {
    sl.registerFactory<WishlistCubit>(() => WishlistCubit(
          getWishlist: sl<GetWishlist>(),
          removeFromWishlist: sl<RemoveFromWishlist>(),
          repository: sl<WishlistRepository>(),
        ));
  }

  // Orders registrations
  if (!sl.isRegistered<OrderRepository>()) {
    sl.registerLazySingleton<OrderRepository>(() => OrderRepositoryImpl());
  }

  if (!sl.isRegistered<GetOrders>()) {
    sl.registerLazySingleton<GetOrders>(() => GetOrders(sl<OrderRepository>()));
  }

  if (!sl.isRegistered<OrdersCubit>()) {
    sl.registerFactory<OrdersCubit>(
        () => OrdersCubit(getOrdersUseCase: sl<GetOrders>()));
  }

  // Track Order registrations
  if (!sl.isRegistered<TrackOrderRepository>()) {
    sl.registerLazySingleton<TrackOrderRepository>(
        () => TrackOrderRepositoryImpl());
  }

  if (!sl.isRegistered<GetTrackOrder>()) {
    sl.registerLazySingleton<GetTrackOrder>(
        () => GetTrackOrder(sl<TrackOrderRepository>()));
  }

  if (!sl.isRegistered<TrackOrderCubit>()) {
    sl.registerFactory<TrackOrderCubit>(
        () => TrackOrderCubit(getTrackOrderUseCase: sl<GetTrackOrder>()));
  }

  // sl.registerLazySingleton(() => CartRepositoryImpl(sl()));

  // Use Cases
  // sl.registerLazySingleton(() => LoginUseCase(sl()));
  // sl.registerLazySingleton(() => RegisterUseCase(sl()));
  // sl.registerLazySingleton(() => GetProductsUseCase(sl<ProductRepositoryImpl>()));
  // sl.registerLazySingleton(() => AddToCartUseCase(sl()));

  // Blocs/Cubits
  // sl.registerFactory(() => AuthBloc(sl(), sl()));
  // sl.registerFactory(() => GroceryCubit(sl()));
  // sl.registerFactory(() => CartBloc(sl()));
}

// Helper function to reset all dependencies
Future<void> reset() async {
  await sl.reset();
  await init();
}

// Helper function to check if dependency is registered
bool isRegistered<T extends Object>() => sl.isRegistered<T>();

// Helper function to get dependency
T get<T extends Object>() => sl.get<T>();

// Helper function to get dependency with parameter
T getWithParam<T extends Object, P extends Object>(P param) =>
    sl.get<T>(param1: param);

// Helper function to register singleton
void registerSingleton<T extends Object>(T instance) {
  sl.registerSingleton<T>(instance);
}

// Helper function to register lazy singleton
void registerLazySingleton<T extends Object>(T Function() factory) {
  sl.registerLazySingleton<T>(factory);
}

// Helper function to register factory
void registerFactory<T extends Object>(T Function() factory) {
  sl.registerFactory<T>(factory);
}

// Helper function to unregister
void unregister<T extends Object>() {
  sl.unregister<T>();
}
