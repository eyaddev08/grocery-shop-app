import 'package:get_it/get_it.dart';

import '../data/repositories/product_details_repository_impl.dart';
import '../data/repositories/similar_product_repository_imp.dart';
import '../domain/repositories/product_details_repository.dart';
import '../domain/repositories/similar_product_repository.dart';
import '../domain/usecases/get_product_details.dart';
import '../domain/usecases/get_similar_product.dart';
import '../presentation/manager/product_details/product_details_cubit.dart';
import '../presentation/manager/similar_product/similar_product_cubit.dart';

class ProductDetailsModule {
  static void init(GetIt sl) {
    // Repository
    if (!sl.isRegistered<ProductDetailsRepository>()) {
      sl.registerLazySingleton<ProductDetailsRepository>(
          () => ProductDetailsRepositoryImpl(sl()));
    }
    if (!sl.isRegistered<SimilarProductRepository>()) {
      sl.registerLazySingleton<SimilarProductRepository>(
          () => SimilarProductRepositoryImpl(sl()));
    }

    // Use Case
    if (!sl.isRegistered<GetProductDetailsUseCase>()) {
      sl.registerLazySingleton(() => GetProductDetailsUseCase(sl()));
    }
    if (!sl.isRegistered<GetSimilarProductUseCase>()) {
      sl.registerLazySingleton(() => GetSimilarProductUseCase(sl()));
    }

    // Cubit
    if (!sl.isRegistered<ProductDetailsCubit>()) {
      sl.registerFactory(() => ProductDetailsCubit(sl()));
    }
    if (!sl.isRegistered<SimilarProductCubit>()) {
      sl.registerFactory(() => SimilarProductCubit(getSimilarProduct: sl()));
    }
  }
}
