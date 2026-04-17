import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/category_entity.dart';
import '../../domain/repositories/category_repository.dart';
import '../datasources/category_local_data_source.dart';
import '../datasources/category_remote_data_source.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  CategoryRepositoryImpl({
    required this.localDataSource,
    required this.remoteDataSource,
    required this.networkInfo,
  });
  final CategoryLocalDataSource localDataSource;
  final CategoryRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  @override
  Future<Either<Failure, List<CategoryEntity>>> getCategories() async {
  try {
      if (await networkInfo.isConnected) {
        final remoteModels = await remoteDataSource.getCategories();
        await localDataSource.cacheCategories(remoteModels);
      }
      final categories = await localDataSource.getLastCategories();

      return Right(categories.map((e) => e.toEntity()).toList());
    } catch (e) {
      try {
        final cached = await localDataSource.getLastCategories();
        if (cached.isNotEmpty) {
          return Right(cached.map((e) => e.toEntity()).toList());
        }
        return Left(ServerFailure(
            'No internet and no cached data ${e.toString()}'));
      } catch (e) {
        return Left(
            CacheFailure( 'Failed to load cache ${e.toString()}'));
      }
    }
  }
}
