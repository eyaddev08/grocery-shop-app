import 'package:dartz/dartz.dart';
import 'package:grocery_shop_app/core/error/failure.dart';
import 'package:grocery_shop_app/features/location/domain/entities/location_entity.dart';
import 'package:grocery_shop_app/features/location/domain/repositories/location_repository.dart';

/// Use case: reverse geocode coordinates into a human readable address.
class ReverseGeocodeUseCase {
  ReverseGeocodeUseCase(this.repository);
  final LocationRepository repository;

  Future<Either<Failure, LocationEntity>> call({
    required double latitude,
    required double longitude,
  }) =>
      repository.reverseGeocode(latitude, longitude);
}
