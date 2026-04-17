import 'package:dartz/dartz.dart';
import 'package:grocery_shop_app/core/error/failure.dart';
import 'package:grocery_shop_app/features/location/domain/entities/place_details.dart';
import 'package:grocery_shop_app/features/location/domain/repositories/location_repository.dart';

/// Use case: fetch full details for a selected suggestion (lat/lng + address).
class GetPlaceDetailsUseCase {
  GetPlaceDetailsUseCase(this.repository);
  final LocationRepository repository;

  Future<Either<Failure, PlaceDetails>> call(String placeId) =>
      repository.getPlaceDetails(placeId);
}
