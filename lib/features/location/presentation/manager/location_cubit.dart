import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:grocery_shop_app/core/error/failure.dart';
import 'package:grocery_shop_app/features/location/domain/entities/location_entity.dart';
import 'package:grocery_shop_app/features/location/domain/entities/place_suggestion.dart';
import 'package:grocery_shop_app/features/location/domain/usecases/cache_location.dart';
import 'package:grocery_shop_app/features/location/domain/usecases/get_cached_locations.dart';
import 'package:grocery_shop_app/features/location/domain/usecases/get_current_location.dart';
import 'package:grocery_shop_app/features/location/domain/usecases/get_place_details.dart';
import 'package:grocery_shop_app/features/location/domain/usecases/reverse_geocode.dart';
import 'package:grocery_shop_app/features/location/domain/usecases/search_places.dart';

import 'location_state.dart';

class LocationCubit extends Cubit<LocationState> {
  LocationCubit({
    required GetCurrentLocationUseCase getCurrentLocation,
    required ReverseGeocodeUseCase reverseGeocode,
    required SearchPlacesUseCase searchPlaces,
    required GetPlaceDetailsUseCase getPlaceDetails,
    required CacheLocationUseCase cacheLocation,
    required GetCachedLocationsUseCase getCachedLocations,
  })  : _getCurrentLocation = getCurrentLocation,
        _reverseGeocode = reverseGeocode,
        _searchPlaces = searchPlaces,
        _getPlaceDetails = getPlaceDetails,
        _cacheLocation = cacheLocation,
        _getCachedLocations = getCachedLocations,
        super(const LocationInitial());

  final GetCurrentLocationUseCase _getCurrentLocation;
  final ReverseGeocodeUseCase _reverseGeocode;
  final SearchPlacesUseCase _searchPlaces;
  final GetPlaceDetailsUseCase _getPlaceDetails;
  final CacheLocationUseCase _cacheLocation;
  final GetCachedLocationsUseCase _getCachedLocations;

  LatLng? _selectedLatLng;
  String? _selectedFormattedAddress;
  String? _selectedStreet;
  String? _selectedDistrict;
  String? _selectedCity;
  String? _selectedCountry;

  /// Initialize cubit: prefetch cached locations and prepare map.
  Future<void> init() async {
    emit(const LocationLoading());
    final Either<Failure, List<LocationEntity>> cachedEither =
        await _getCachedLocations();

    List<LocationEntity> cached = [];
    cachedEither.fold((_) {}, (list) => cached = list);

    // Try to get current location for initial camera.
    final Either<Failure, LatLng> locEither = await _getCurrentLocation();

    locEither.fold(
      (_) {
        // Fallback to a default camera (e.g. some central coordinates).
        const fallback = LatLng(15.35724, 44.17961); // Riyadh as example
        _selectedLatLng = fallback;
        emit(
          LocationMapReady(
            cameraPosition: const CameraPosition(
              target: fallback,
              zoom: 14,
            ),
            selectedLatLng: fallback,
            recentLocations: cached,
          ),
        );
      },
      (latLng) {
        _selectedLatLng = latLng;
        emit(
          LocationMapReady(
            cameraPosition: CameraPosition(
              target: latLng,
              zoom: 16,
            ),
            selectedLatLng: latLng,
            recentLocations: cached,
          ),
        );
      },
    );
  }

  /// Re-center on current device location.
  Future<void> getCurrentLocation() async {
    emit(const LocationLoading());
    final Either<Failure, LatLng> res = await _getCurrentLocation();
    res.fold(
      (f) => emit(LocationError(f.message)),
      (latLng) {
        _selectedLatLng = latLng;
        final current = state;
        List<LocationEntity> recent = const [];
        if (current is LocationMapReady) {
          recent = current.recentLocations;
        }
        emit(
          LocationMapReady(
            cameraPosition: CameraPosition(target: latLng, zoom: 16),
            selectedLatLng: latLng,
            recentLocations: recent,
          ),
        );
      },
    );
  }

  void moveMarker(LatLng latLng) {
    _selectedLatLng = latLng;
    _selectedFormattedAddress = null;
    _selectedStreet = null;
    _selectedDistrict = null;
    _selectedCity = null;
    _selectedCountry = null;
    final current = state;
    if (current is LocationMapReady) {
      // Reset reverse geocode state when marker moves
      emit(
        current.copyWith(
          selectedLatLng: latLng,
          cameraPosition: CameraPosition(
            target: latLng,
            zoom: current.cameraPosition.zoom.clamp(10.0, 20.0),
          ),
        ),
      );
    } else {
      // If not in MapReady state, initialize it
      emit(
        LocationMapReady(
          cameraPosition: CameraPosition(target: latLng, zoom: 16),
          selectedLatLng: latLng,
          recentLocations: const [],
        ),
      );
    }
  }

  /// Confirm selection: reverse geocode if possible.
  ///
  /// If reverse geocoding fails for any reason (offline, API error, etc.)
  /// we still return a coordinates-only `LocationEntity` so that the user
  /// can proceed without being blocked by network issues.
  Future<void> confirmSelection() async {
    final LatLng? selected = _selectedLatLng;
    if (selected == null) {
      emit(const LocationError('no_location_selected'));
      return;
    }
    if (_selectedFormattedAddress != null) {
      final cachedLocation = LocationEntity(
        latitude: selected.latitude,
        longitude: selected.longitude,
        pickedAt: DateTime.now(),
        formattedAddress: _selectedFormattedAddress,
        street: _selectedStreet,
        district: _selectedDistrict,
        city: _selectedCity,
        country: _selectedCountry,
      );
      await _cacheLocation(cachedLocation);
      emit(LocationReverseLoaded(location: cachedLocation, isOffline: false));
      return;
    }

    emit(const LocationReverseLoading());

    final Either<Failure, LocationEntity> res = await _reverseGeocode(
      latitude: selected.latitude,
      longitude: selected.longitude,
    );

    await res.fold(
      (f) async {
        final offlineLocation = LocationEntity(
          latitude: selected.latitude,
          longitude: selected.longitude,
          pickedAt: DateTime.now(),
          formattedAddress: null,
        );
        await _cacheLocation(offlineLocation);
        emit(
          LocationReverseLoaded(
            location: offlineLocation,
            isOffline: f is NetworkFailure,
          ),
        );
      },
      (entity) async {
        // Cache the location after successful reverse geocode
        await _cacheLocation(entity);
        emit(
          LocationReverseLoaded(
            location: entity,
            isOffline: false,
          ),
        );
      },
    );
  }

  /// Search suggestions using Google Places Autocomplete.
  Future<void> searchPlaces(String query) async {
    emit(const LocationSuggestionsLoading());
    final Either<Failure, List<PlaceSuggestion>> res =
        await _searchPlaces(query);
    res.fold(
      (f) => emit(LocationError(f.message)),
      (list) => emit(LocationSuggestionsLoaded(list)),
    );
  }

  /// Search suggestions without emitting states (for TypeAheadField)
  Future<List<PlaceSuggestion>> getSearchSuggestions(String query) async {
    final Either<Failure, List<PlaceSuggestion>> res =
        await _searchPlaces(query);
    return res.fold(
      (f) => throw Exception(f.message),
      (list) => list,
    );
  }

  /// When user selects a suggestion, fetch its details and update marker.
  Future<void> selectSuggestion(String placeId) async {
    emit(const LocationLoading());
    final res = await _getPlaceDetails(placeId);
    res.fold(
      (f) => emit(LocationError(f.message)),
      (details) {
        final latLng = details.location;
        _selectedLatLng = latLng;
        _selectedFormattedAddress = details.formattedAddress;
        _selectedStreet = details.street;
        _selectedDistrict = details.district;
        _selectedCity = details.city;
        _selectedCountry = details.country;

        final current = state;
        List<LocationEntity> recent = const [];
        if (current is LocationMapReady) {
          recent = current.recentLocations;
        }
        emit(
          LocationMapReady(
            cameraPosition: CameraPosition(target: latLng, zoom: 16),
            selectedLatLng: latLng,
            recentLocations: recent,
          ),
        );
      },
    );
  }

  /// Load last cached picks (can be used by UI widget).
  Future<void> loadCachedLocations() async {
    final res = await _getCachedLocations();
    res.fold(
      (f) => emit(LocationError(f.message)),
      (list) => emit(LocationCachedListLoaded(list)),
    );
  }
}
