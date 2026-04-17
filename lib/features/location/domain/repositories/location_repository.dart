import 'package:dartz/dartz.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:grocery_shop_app/core/error/failure.dart';
import 'package:grocery_shop_app/features/location/domain/entities/location_entity.dart';
import 'package:grocery_shop_app/features/location/domain/entities/place_details.dart';
import 'package:grocery_shop_app/features/location/domain/entities/place_suggestion.dart';

/// Abstraction for all location‑related operations.
///
/// Implemented in the data layer and consumed by the domain use cases.
abstract class LocationRepository {
  Future<Either<Failure, LocationEntity>> reverseGeocode(
    double latitude,
    double longitude,
  );

  Future<Either<Failure, LatLng>> getCurrentLocation();

  Future<Either<Failure, List<PlaceSuggestion>>> searchPlaces(
    String query,
  );

  Future<Either<Failure, PlaceDetails>> getPlaceDetails(String placeId);

  Future<Either<Failure, Unit>> cacheLocation(LocationEntity location);

  Future<Either<Failure, List<LocationEntity>>> getCachedLocations();
}
