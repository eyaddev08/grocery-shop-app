import 'package:dartz/dartz.dart';
import 'package:grocery_shop_app/core/error/failure.dart';
import 'package:grocery_shop_app/features/location/domain/entities/location_entity.dart';
import 'package:grocery_shop_app/features/location/domain/repositories/location_repository.dart';

class GetCachedLocationsUseCase {
  GetCachedLocationsUseCase(this.repository);
  final LocationRepository repository;

  Future<Either<Failure, List<LocationEntity>>> call() =>
      repository.getCachedLocations();
}
