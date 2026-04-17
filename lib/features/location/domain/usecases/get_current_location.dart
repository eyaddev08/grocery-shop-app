import 'package:dartz/dartz.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:grocery_shop_app/core/error/failure.dart';
import 'package:grocery_shop_app/features/location/domain/repositories/location_repository.dart';

/// Use case: get the device current GPS location.
class GetCurrentLocationUseCase {
  GetCurrentLocationUseCase(this.repository);
  final LocationRepository repository;

  Future<Either<Failure, LatLng>> call() => repository.getCurrentLocation();
}
