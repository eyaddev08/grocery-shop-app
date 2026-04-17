import 'package:get_it/get_it.dart';
import '../domain/usecases/change_password.dart';
import '../domain/usecases/delete_account.dart';
import '../domain/usecases/logout.dart';
import '../domain/usecases/upload_avatar.dart';
import '../data/datasources/profile_local_data_source.dart';
import '../data/datasources/profile_remote_data_source.dart';
import '../data/repositories/profile_repository_impl.dart';
import '../domain/repositories/profile_repository.dart';
import '../domain/usecases/get_profile.dart';
import '../domain/usecases/update_profile.dart';
import '../presentation/manager/profile_cubit.dart';

class ProfileModule {
  static void init(GetIt sl) {
    // Data sources
    sl.registerLazySingleton<ProfileRemoteDataSource>(
      () => ProfileRemoteDataSourceImpl(sl()),
    );
    sl.registerLazySingleton<ProfileLocalDataSource>(
      () => ProfileLocalDataSourceImpl(),
    );

    // Repository
    sl.registerLazySingleton<ProfileRepository>(
      () => ProfileRepositoryImpl(sl(), sl()),
    );

    // Use cases
    sl.registerLazySingleton(() => GetProfileUseCase(sl()));
    sl.registerLazySingleton(() => UpdateProfileUseCase(sl()));
    sl.registerLazySingleton(() => UploadAvatarUseCase(sl()));
    sl.registerLazySingleton(() => ChangePasswordUseCase(sl()));
    sl.registerLazySingleton(() => LogoutUseCase(sl()));
    sl.registerLazySingleton(() => DeleteAccountUseCase(sl()));

    // Cubit
    sl.registerFactory(() => ProfileCubit(
          getProfile: sl(),
          updateProfile: sl(),
          uploadAvatar: sl(),
          changePassword: sl(),
          logout: sl(),
          deleteAccount: sl(),
        ));
  }
}
