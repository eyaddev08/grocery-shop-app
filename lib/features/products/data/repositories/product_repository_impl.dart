import 'package:dartz/dartz.dart';
import '../../../../core/error/exception.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/product_entity.dart';
import '../../domain/repositories/product_repository.dart';
import '../datasources/product_local_data_source.dart';
import '../datasources/product_remote_data_source.dart';
import '../models/product_model.dart';

class ProductRepositoryImpl implements ProductRepository {
  ProductRepositoryImpl({
    required this.localDataSource,
    required this.remoteDataSource,
    required this.networkInfo,
  });
  final ProductLocalDataSource localDataSource;
  final ProductRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;


  Future<Either<Failure, List<ProductEntity>>> _fetchData({
    required Future<List<ProductModel>> Function() getRemote,
    required Future<List<ProductModel>> Function() getLocal,
    required Future<void> Function(List<ProductModel>) cacheLocal,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteModels = await getRemote();
        await cacheLocal(remoteModels);
        return Right(remoteModels);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      }
    } else {
      try {
        final cached = await getLocal();
        if (cached.isEmpty) {
          return Left(CacheFailure('No internet and no cached data'));
        }
        return Right(cached);
      } on CacheException {
        return Left(CacheFailure('Failed to load local cache'));
      }
    }
  }

  @override
  Future<Either<Failure, List<ProductEntity>>> getProducts() => _fetchData(
      getRemote: remoteDataSource.getProducts,
      getLocal: localDataSource.getLastProducts,
      cacheLocal: localDataSource.cacheProducts,
    );

  @override
  Future<Either<Failure, List<ProductEntity>>> getDealsProducts() => _fetchData(
      getRemote: remoteDataSource.getDealsProducts,
      getLocal: localDataSource.getLastDealsProducts,
      cacheLocal: localDataSource.cacheDealsProducts,
    );

  @override
  Future<Either<Failure, List<ProductEntity>>> getRecommendedProducts() => _fetchData(
      getRemote: remoteDataSource.getRecommendedProducts,
      getLocal: localDataSource.getLastRecommendedProducts,
      cacheLocal: localDataSource.cacheRecommendedProducts,
    );

  @override
  Future<Either<Failure, ProductEntity>> getProductById(String id) async {
    try {
      final allLocal = await localDataSource.getLastProducts();
      final dealsLocal = await localDataSource.getLastDealsProducts();
      final recLocal = await localDataSource.getLastRecommendedProducts();

      final List<ProductEntity> totalPool = [...allLocal, ...dealsLocal, ...recLocal];

      final product = totalPool.firstWhere((p) => p.id == id);
      return Right(product);
    } catch (e) {
      return Left(ServerFailure('Product not found in local cache'));
    }
  }
}
