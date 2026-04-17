import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import '../../core/network/network_info.dart';
import '../../features/auth/di/auth_module.dart';
import '../../features/cart/di/cart_module.dart';

import '../../features/categories/di/category_module.dart';
import '../../features/checkout/di/checkout_module.dart';
import '../../features/location/di/location_module.dart';
import '../../features/orders/di/order_module.dart';
import '../../features/payment/di/payment_module.dart';
import '../../features/product_details/di/product_details_module.dart';
import '../../features/products/di/product_module.dart';
import '../../features/profile/di/profile_module.dart';
import '../../features/search/di/search_module.dart';

import '../../features/track_order/di/track_order_module.dart';

import '../../features/wishlist/di/wishlist_module.dart';


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
  await Hive.initFlutter();

  // -----------------------------
  // Core: NetworkInfo
  // -----------------------------
  if (!sl.isRegistered<NetworkInfo>()) {
    sl.registerLazySingleton<NetworkInfo>(
      () => NetworkInfo(Connectivity()),
    );
  }
  // -----------------------------
  // Auth Feature
  // -----------------------------
  AuthModule.init(sl);
  // -----------------------------
  // Profile
  // -----------------------------
  ProfileModule.init(sl);
  // -----------------------------
  // Location Feature
  // -----------------------------
  await LocationModule.init(sl);
  // -----------------------------
  // Categories
  // -----------------------------
  await CategoryModule.init(sl);
  // -----------------------------
  // Products
  // -----------------------------
  await ProductModule.init(sl);
  // -----------------------------
  // Product Details
  // -----------------------------
  ProductDetailsModule.init(sl);
  // -----------------------------
  // Search Products
  // -----------------------------
  await SearchModule.init(sl);
  // -----------------------------
  // Cart
  // -----------------------------
  await CartModule.init(sl);
  // -----------------------------
  // Checkout
  // -----------------------------
  await CheckoutModule.init(sl);
  // -----------------------------
  // Payment
  // -----------------------------
  await PaymentModule.init(sl);
  // -----------------------------
  // Wishlist
  // -----------------------------
  await WishlistModule.init(sl);
  // -----------------------------
  // Orders
  // -----------------------------
  await OrderModule.init(sl);
  // -----------------------------
  // Track Order
  // -----------------------------
  await TrackOrderModule.init(sl);
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
