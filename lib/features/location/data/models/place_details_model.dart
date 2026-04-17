import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:grocery_shop_app/features/location/domain/entities/place_details.dart';

/// Data model for Google Place Details response.
class PlaceDetailsModel {
  final String placeId;
  final LatLng location;
  final String? formattedAddress;
  final String? street;
  final String? district;
  final String? city;
  final String? country;
  final String? postalCode;

  const PlaceDetailsModel({
    required this.placeId,
    required this.location,
    this.formattedAddress,
    this.street,
    this.district,
    this.city,
    this.country,
    this.postalCode,
  });

  factory PlaceDetailsModel.fromJson(Map<String, dynamic> json) {
    final result = json['result'] as Map<String, dynamic>;
    final geometry = result['geometry'] as Map<String, dynamic>;
    final locationJson = geometry['location'] as Map<String, dynamic>;

    final components =
        (result['address_components'] as List<dynamic>? ?? <dynamic>[])
            .cast<Map<String, dynamic>>();

    String? _findType(String type) {
      final match = components.firstWhere(
        (c) => (c['types'] as List).contains(type),
        orElse: () => <String, dynamic>{},
      );
      if (match.isEmpty) return null;
      return match['long_name'] as String?;
    }

    return PlaceDetailsModel(
      placeId: result['place_id'] as String,
      location: LatLng(
        (locationJson['lat'] as num).toDouble(),
        (locationJson['lng'] as num).toDouble(),
      ),
      formattedAddress: result['formatted_address'] as String?,
      street: _findType('route'),
      district: _findType('sublocality') ?? _findType('sublocality_level_1'),
      city: _findType('locality'),
      country: _findType('country'),
      postalCode: _findType('postal_code'),
    );
  }

  PlaceDetails toEntity() {
    return PlaceDetails(
      placeId: placeId,
      location: location,
      formattedAddress: formattedAddress,
      street: street,
      district: district,
      city: city,
      country: country,
      postalCode: postalCode,
    );
  }
}


