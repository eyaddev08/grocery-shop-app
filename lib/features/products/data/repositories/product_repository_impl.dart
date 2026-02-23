import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../../domain/entities/product_entity.dart';
import '../../domain/repositories/product_repository.dart';
import '../datasources/product_local_data_source.dart';
import '../datasources/product_remote_data_source.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductLocalDataSource localDataSource;
  final ProductRemoteDataSource remoteDataSource;

  ProductRepositoryImpl({
    required this.localDataSource,
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, List<ProductEntity>>> getProducts() async {
    try {
      final remoteModels = await remoteDataSource.getProducts();

      // Cache them
      await localDataSource.cacheProducts(remoteModels);

      // Convert to entities
      return Right(remoteModels.map((e) => e.toEntity()).toList());
    } catch (e) {
      // Fallback to local
      try {
        final cached = await localDataSource.getLastProducts();
        if (cached.isNotEmpty) {
          return Right(cached.map((e) => e.toEntity()).toList());
        }
        return Left(ServerFailure(message: 'No internet and no cached data'));
      } catch (e) {
        return Left(CacheFailure(message: 'Failed to load cache'));
      }
    }
  }
}
