import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../data/datasources/checkout_local_data_source.dart';
import '../data/datasources/checkout_remote_data_source.dart';
import '../data/models/address_model.dart';
import '../data/repositories/address_repository_impl.dart';
import '../domain/repositories/address_repository.dart';
import '../domain/usecases/add_address.dart';
import '../domain/usecases/delete_address.dart';
import '../domain/usecases/get_address_type.dart';
import '../domain/usecases/get_addresses.dart';
import '../domain/usecases/set_default_address.dart';
import '../domain/usecases/update_address.dart';
import '../presentation/manager/checkout_cubit.dart';

class CheckoutModule {
  static Future<void> init(GetIt sl) async {
    // Checkout cache box (dynamic)
    if (!Hive.isAdapterRegistered(3)) {
      Hive.registerAdapter(AddressModelAdapter());
    }
    if (!Hive.isBoxOpen('address_cache')) {
      await Hive.openBox<AddressModel>('address_cache');
    }

    // Data Sources
    if (!sl.isRegistered<CheckoutLocalDataSource>()) {
      sl.registerLazySingleton<CheckoutLocalDataSource>(() =>
          CheckoutLocalDataSourceImpl(addressBox: Hive.box('address_cache')));
    }
    if (!sl.isRegistered<CheckoutRemoteDataSource>()) {
      sl.registerLazySingleton<CheckoutRemoteDataSource>(() =>
          CheckoutRemoteDataSourceImpl(
              client: sl<Dio>(instanceName: 'authDio')));
    }

    // Repository
    if (!sl.isRegistered<AddressRepository>()) {
      sl.registerLazySingleton<AddressRepository>(() => AddressRepositoryImpl(
            localDataSource: sl(),
            remoteDataSource: sl(),
            networkInfo: sl(),
          ));
    }

    // Use Cases
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

    // Cubit
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
  }
}
