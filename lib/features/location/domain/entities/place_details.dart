import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

/// Details about a selected place returned from Google Places API.
class PlaceDetails extends Equatable {

  const PlaceDetails({
    required this.placeId,
    required this.location,
    this.formattedAddress,
    this.street,
    this.district,
    this.city,
    this.country,
    this.postalCode,
  });
  final String placeId;
  final LatLng location;
  final String? formattedAddress;
  final String? street;
  final String? district;
  final String? city;
  final String? country;
  final String? postalCode;

  @override
  List<Object?> get props => [
        placeId,
        location,
        formattedAddress,
        street,
        district,
        city,
        country,
        postalCode,
      ];
}


