import 'package:get_it/get_it.dart';

import '../data/datasources/track_order_remote_data_source.dart';
import '../data/repositories/track_order_repository_impl.dart';
import '../domain/repositories/track_order_repository.dart';
import '../domain/usecases/get_track_order.dart';
import '../presentation/manager/track_order_cubit.dart';

class TrackOrderModule {
  static Future<void> init(GetIt sl) async {
    // Data Source
    if (!sl.isRegistered<TrackOrderRemoteDataSource>()) {
      sl.registerLazySingleton<TrackOrderRemoteDataSource>(
          () => TrackOrderRemoteDataSourceImpl());
    }

    // Repository
    if (!sl.isRegistered<TrackOrderRepository>()) {
      sl.registerLazySingleton<TrackOrderRepository>(
          () => TrackOrderRepositoryImpl(remoteDataSource: sl()));
    }

    // Use Case
    if (!sl.isRegistered<GetTrackOrderUseCase>()) {
      sl.registerLazySingleton<GetTrackOrderUseCase>(
          () => GetTrackOrderUseCase(sl<TrackOrderRepository>()));
    }

    // Cubit
    if (!sl.isRegistered<TrackOrderCubit>()) {
      sl.registerFactory<TrackOrderCubit>(() =>
          TrackOrderCubit(getTrackOrderUseCase: sl<GetTrackOrderUseCase>()));
    }
  }
}
