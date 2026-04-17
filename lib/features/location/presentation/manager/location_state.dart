import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:grocery_shop_app/features/location/domain/entities/location_entity.dart';
import 'package:grocery_shop_app/features/location/domain/entities/place_suggestion.dart';

abstract class LocationState extends Equatable {
  const LocationState();

  @override
  List<Object?> get props => [];
}

class LocationInitial extends LocationState {
  const LocationInitial();
}

class LocationLoading extends LocationState {
  const LocationLoading();
}

class LocationMapReady extends LocationState {

  const LocationMapReady({
    required this.cameraPosition,
    required this.selectedLatLng,
    this.isOffline = false,
    this.recentLocations = const [],
  });
  final CameraPosition cameraPosition;
  final LatLng selectedLatLng;
  final bool isOffline;
  final List<LocationEntity> recentLocations;

  LocationMapReady copyWith({
    CameraPosition? cameraPosition,
    LatLng? selectedLatLng,
    bool? isOffline,
    List<LocationEntity>? recentLocations,
  }) {
    return LocationMapReady(
      cameraPosition: cameraPosition ?? this.cameraPosition,
      selectedLatLng: selectedLatLng ?? this.selectedLatLng,
      isOffline: isOffline ?? this.isOffline,
      recentLocations: recentLocations ?? this.recentLocations,
    );
  }

  @override
  List<Object?> get props =>
      [cameraPosition, selectedLatLng, isOffline, recentLocations];
}

class LocationReverseLoading extends LocationState {
  const LocationReverseLoading();
}

class LocationReverseLoaded extends LocationState {

  const LocationReverseLoaded({
    required this.location,
    required this.isOffline,
  });
  final LocationEntity location;
  final bool isOffline;

  @override
  List<Object?> get props => [location, isOffline];
}

class LocationSuggestionsLoading extends LocationState {
  const LocationSuggestionsLoading();
}

class LocationSuggestionsLoaded extends LocationState {

  const LocationSuggestionsLoaded(this.suggestions);
  final List<PlaceSuggestion> suggestions;

  @override
  List<Object?> get props => [suggestions];
}

class LocationCachedListLoaded extends LocationState {

  const LocationCachedListLoaded(this.locations);
  final List<LocationEntity> locations;

  @override
  List<Object?> get props => [locations];
}

class LocationError extends LocationState {

  const LocationError(this.message);
  final String message;

  @override
  List<Object?> get props => [message];
}


