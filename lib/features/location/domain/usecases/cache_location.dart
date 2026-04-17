import 'package:dartz/dartz.dart';
import 'package:grocery_shop_app/core/error/failure.dart';
import 'package:grocery_shop_app/features/location/domain/entities/location_entity.dart';
import 'package:grocery_shop_app/features/location/domain/repositories/location_repository.dart';

/// Use case: cache a picked location locally (Hive).
class CacheLocationUseCase {
  CacheLocationUseCase(this.repository);
  final LocationRepository repository;

  Future<Either<Failure, Unit>> call(LocationEntity location) =>
      repository.cacheLocation(location);
}
