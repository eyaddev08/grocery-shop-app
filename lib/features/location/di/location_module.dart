import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';

import '../../../core/network/network_info.dart';
import '../data/datasources/location_local_data_source.dart';
import '../data/datasources/location_remote_data_source.dart';
import '../data/models/location_model.dart';
import '../data/repositories/location_repository_impl.dart';
import '../domain/repositories/location_repository.dart';
import '../domain/usecases/cache_location.dart';
import '../domain/usecases/get_cached_locations.dart';
import '../domain/usecases/get_current_location.dart';
import '../domain/usecases/get_place_details.dart';
import '../domain/usecases/reverse_geocode.dart';
import '../domain/usecases/search_places.dart';
import '../presentation/manager/location_cubit.dart';

class LocationModule {
  static Future<void> init(GetIt sl) async{
    if (!Hive.isAdapterRegistered(2)) {
    Hive.registerAdapter<LocationModel>(LocationModelAdapter());
  }
  if (!Hive.isBoxOpen(LocationLocalDataSourceImpl.locationCacheBoxName)) {
    await Hive.openBox<LocationModel>(
      LocationLocalDataSourceImpl.locationCacheBoxName,
    );
  }

  // Data Sources
  if (!sl.isRegistered<LocationLocalDataSource>()) {
    sl.registerLazySingleton<LocationLocalDataSource>(
      () => LocationLocalDataSourceImpl(
        Hive.box<LocationModel>(
            LocationLocalDataSourceImpl.locationCacheBoxName),
      ),
    );
  }
  if (!sl.isRegistered<LocationRemoteDataSource>()) {
    sl.registerLazySingleton<LocationRemoteDataSource>(
      () => LocationRemoteDataSourceImpl(sl<Dio>()),
    );
  }
 

  // Repository
    if (!sl.isRegistered<LocationRepository>()) {
    sl.registerLazySingleton<LocationRepository>(
      () => LocationRepositoryImpl(
        remoteDataSource: sl<LocationRemoteDataSource>(),
        localDataSource: sl<LocationLocalDataSource>(),
        networkInfo: sl<NetworkInfo>(),
      ),
    );
  }

  // UseCases
  if (!sl.isRegistered<GetCurrentLocationUseCase>()) {
    sl.registerLazySingleton(
      () => GetCurrentLocationUseCase(sl<LocationRepository>()),
    );
  }
  if (!sl.isRegistered<ReverseGeocodeUseCase>()) {
    sl.registerLazySingleton(
      () => ReverseGeocodeUseCase(sl<LocationRepository>()),
    );
  }
  if (!sl.isRegistered<SearchPlacesUseCase>()) {
    sl.registerLazySingleton(
      () => SearchPlacesUseCase(sl<LocationRepository>()),
    );
  }
  if (!sl.isRegistered<GetPlaceDetailsUseCase>()) {
    sl.registerLazySingleton(
      () => GetPlaceDetailsUseCase(sl<LocationRepository>()),
    );
  }
  if (!sl.isRegistered<CacheLocationUseCase>()) {
    sl.registerLazySingleton(
      () => CacheLocationUseCase(sl<LocationRepository>()),
    );
  }
  if (!sl.isRegistered<GetCachedLocationsUseCase>()) {
    sl.registerLazySingleton(
      () => GetCachedLocationsUseCase(sl<LocationRepository>()),
    );
  }
  // Cubit
  if (!sl.isRegistered<LocationCubit>()) {
    sl.registerFactory<LocationCubit>(
      () => LocationCubit(
        getCurrentLocation: sl<GetCurrentLocationUseCase>(),
        reverseGeocode: sl<ReverseGeocodeUseCase>(),
        searchPlaces: sl<SearchPlacesUseCase>(),
        getPlaceDetails: sl<GetPlaceDetailsUseCase>(),
        cacheLocation: sl<CacheLocationUseCase>(),
        getCachedLocations: sl<GetCachedLocationsUseCase>(),
      ),
    );
  }
  }
}
