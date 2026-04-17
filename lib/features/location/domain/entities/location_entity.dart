import 'package:equatable/equatable.dart';

/// Domain entity that represents a picked location in the app.
///
/// This is what the rest of the app (e.g. checkout / address features)
/// should depend on – not on any data or framework-specific models.
class LocationEntity extends Equatable {
  const LocationEntity({
    required this.latitude,
    required this.longitude,
    required this.pickedAt,
    this.formattedAddress,
    this.street,
    this.district,
    this.city,
    this.country,
    this.postalCode,
  });
  final double latitude;
  final double longitude;

  /// A human‑readable address string. May be `null` when offline.
  final String? formattedAddress;
  final String? street;
  final String? district;
  final String? city;
  final String? country;
  final String? postalCode;

  /// When this location was picked by the user.
  final DateTime pickedAt;

  @override
  List<Object?> get props => [
        latitude,
        longitude,
        formattedAddress,
        street,
        district,
        city,
        country,
        postalCode,
        pickedAt,
      ];

  /// Core logic for parsing a human readable string format
  /// of the LocationEntity to be used across the app (address form, preview, etc)
  String get getHumanReadableAddress {
    if (formattedAddress != null &&
        formattedAddress!.trim().isNotEmpty &&
        formattedAddress != 'Unnamed Road') {
      return formattedAddress!;
    }

    final fallbackList = [street, district, city, country]
        .where((e) => e != null && e.trim().isNotEmpty)
        .toList();

    if (fallbackList.isNotEmpty) {
      return fallbackList.join(', ');
    }

    return 'Unknown Location';
  }
}
