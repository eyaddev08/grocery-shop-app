import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Services
// import 'package:grocery_shop_app/core/services/api_service.dart';
// import 'package:grocery_shop_app/core/services/auth_service.dart';
// import 'package:grocery_shop_app/core/services/cart_service.dart';
// import 'package:grocery_shop_app/core/services/storage_service.dart';
// import 'package:grocery_shop_app/core/services/notification_service.dart';

// Repositories
// import 'package:grocery_shop_app/features/auth/data/repositories/auth_repository_impl.dart';
// import 'package:grocery_shop_app/features/products/data/repositories/product_repository_impl.dart';
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
  sl.registerLazySingleton(() => sharedPreferences);

  // Services
  // sl.registerLazySingleton(() => ApiService());
  // sl.registerLazySingleton(() => AuthService(sl()));
  // sl.registerLazySingleton(() => CartService(sl()));
  // sl.registerLazySingleton(() => StorageService(sl()));
  // sl.registerLazySingleton(() => NotificationService());

  // Repositories
  // sl.registerLazySingleton(() => AuthRepositoryImpl(sl(), sl()));
  // sl.registerLazySingleton(() => ProductRepositoryImpl(sl()));
  // sl.registerLazySingleton(() => CartRepositoryImpl(sl()));

  // Use Cases
  // sl.registerLazySingleton(() => LoginUseCase(sl()));
  // sl.registerLazySingleton(() => RegisterUseCase(sl()));
  // sl.registerLazySingleton(() => GetProductsUseCase(sl()));
  // sl.registerLazySingleton(() => AddToCartUseCase(sl()));

  // Blocs/Cubits
  // sl.registerFactory(() => AuthBloc(sl(), sl()));
  // sl.registerFactory(() => ProductsBloc(sl()));
  // sl.registerFactory(() => CartBloc(sl()));
}

// Helper function to reset all dependencies
Future<void> reset() async {
  await sl.reset();
  await init();
}

// Helper function to check if dependency is registered
bool isRegistered<T extends Object>() {
  return sl.isRegistered<T>();
}

// Helper function to get dependency
T get<T extends Object>() {
  return sl.get<T>();
}

// Helper function to get dependency with parameter
T getWithParam<T extends Object, P extends Object>(P param) {
  return sl.get<T>(param1: param);
}

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
