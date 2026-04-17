import 'package:dartz/dartz.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:grocery_shop_app/core/error/failure.dart';
import 'package:grocery_shop_app/core/network/network_info.dart';
import 'package:grocery_shop_app/features/location/data/datasources/location_local_data_source.dart';
import 'package:grocery_shop_app/features/location/data/datasources/location_remote_data_source.dart';
import 'package:grocery_shop_app/features/location/data/models/location_model.dart';
import 'package:grocery_shop_app/features/location/domain/entities/location_entity.dart';
import 'package:grocery_shop_app/features/location/domain/entities/place_details.dart';
import 'package:grocery_shop_app/features/location/domain/entities/place_suggestion.dart';
import 'package:grocery_shop_app/features/location/domain/repositories/location_repository.dart';

class LocationRepositoryImpl implements LocationRepository {
  LocationRepositoryImpl({
    required LocationRemoteDataSource remoteDataSource,
    required LocationLocalDataSource localDataSource,
    required NetworkInfo networkInfo,
  })  : _remote = remoteDataSource,
        _local = localDataSource,
        _networkInfo = networkInfo;

  final LocationRemoteDataSource _remote;
  final LocationLocalDataSource _local;
  final NetworkInfo _networkInfo;

  @override
  Future<Either<Failure, LatLng>> getCurrentLocation() async {
    try {
      final serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        return Left(
          ValidationFailure(
            message: 'Location services disabled',
            errors: const {},
          ),
        );
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
      if (permission == LocationPermission.denied) {
        return Left(
          ValidationFailure(
            message: 'location_permission_denied',
            errors: const {},
          ),
        );
      }
      if (permission == LocationPermission.deniedForever) {
        return Left(
          ValidationFailure(
            message: 'Location permission denied forever',
            errors: const {},
          ),
        );
      }

      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      return Right(LatLng(position.latitude, position.longitude));
    } catch (e) {
      return Left(
        ServerFailure('Failed to get current location'),
      );
    }
  }

  @override
  Future<Either<Failure, LocationEntity>> reverseGeocode(
    double latitude,
    double longitude,
  ) async {
    final isOnline = await _networkInfo.isConnected;
    if (!isOnline) {
      return Left(
        NetworkFailure( 'offline'),
      );
    }
    try {
      final details = await _remote.reverseGeocode(
        latitude: latitude,
        longitude: longitude,
      );

      final entity = LocationEntity(
        latitude: details.location.latitude,
        longitude: details.location.longitude,
        pickedAt: DateTime.now(),
        formattedAddress: details.formattedAddress,
        street: details.street,
        district: details.district,
        city: details.city,
        country: details.country,
        postalCode: details.postalCode,
      );

      // Cache successful reverse geocode.
      await _local.cacheLocation(LocationModel.fromEntity(entity));

      return Right(entity);
    } catch (e) {
      return Left(
        ServerFailure( 'Reverse geocode failed: $e'),
      );
    }
  }

  @override
  Future<Either<Failure, List<PlaceSuggestion>>> searchPlaces(
    String query,
  ) async {
    final isOnline = await _networkInfo.isConnected;
    if (!isOnline) {
      return Left(NetworkFailure( 'offline'));
    }
    try {
      final models = await _remote.searchPlaces(query);
      return Right(models.map((m) => m.toEntity()).toList());
    } catch (e) {
      return Left(ServerFailure( 'Search places failed: $e'));
    }
  }

  @override
  Future<Either<Failure, PlaceDetails>> getPlaceDetails(String placeId) async {
    final isOnline = await _networkInfo.isConnected;
    if (!isOnline) {
      return Left(NetworkFailure( 'offline'));
    }
    try {
      final model = await _remote.getPlaceDetails(placeId);
      final entity = model.toEntity();
      // Cache as a picked location as well.
      final locationEntity = LocationEntity(
        latitude: entity.location.latitude,
        longitude: entity.location.longitude,
        pickedAt: DateTime.now(),
        formattedAddress: entity.formattedAddress,
        street: entity.street,
        district: entity.district,
        city: entity.city,
        country: entity.country,
        postalCode: entity.postalCode,
      );
      await _local.cacheLocation(LocationModel.fromEntity(locationEntity));
      return Right(entity);
    } catch (e) {
      return Left(ServerFailure('Get place details failed'));
    }
  }

  @override
  Future<Either<Failure, Unit>> cacheLocation(LocationEntity location) async {
    try {
      await _local.cacheLocation(LocationModel.fromEntity(location));
      return const Right(unit);
    } catch (e) {
      return Left(CacheFailure( 'Cache location failed'));
    }
  }

  @override
  Future<Either<Failure, List<LocationEntity>>> getCachedLocations() async {
    try {
      final models = await _local.getLastLocations();
      return Right(models.map((m) => m.toEntity()).toList());
    } catch (e) {
      return Left(CacheFailure( 'Get cached locations failed'));
    }
  }
}
