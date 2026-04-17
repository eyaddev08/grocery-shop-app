import 'package:hive/hive.dart';
import 'package:grocery_shop_app/features/location/domain/entities/location_entity.dart';

part 'location_model.g.dart';

/// Hive model used to cache the last picked locations locally.
@HiveType(typeId: 2)
class LocationModel extends HiveObject {
  @HiveField(0)
  final double latitude;

  @HiveField(1)
  final double longitude;

  @HiveField(2)
  final String? formattedAddress;

  @HiveField(3)
  final String? street;

  @HiveField(4)
  final String? district;

  @HiveField(5)
  final String? city;

  @HiveField(6)
  final String? country;

  @HiveField(7)
  final String? postalCode;

  @HiveField(8)
  final DateTime pickedAt;

   LocationModel({
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

  factory LocationModel.fromEntity(LocationEntity entity) => LocationModel(
      latitude: entity.latitude,
      longitude: entity.longitude,
      pickedAt: entity.pickedAt,
      formattedAddress: entity.formattedAddress,
      street: entity.street,
      district: entity.district,
      city: entity.city,
      country: entity.country,
      postalCode: entity.postalCode,
    );

  LocationEntity toEntity() => LocationEntity(
      latitude: latitude,
      longitude: longitude,
      pickedAt: pickedAt,
      formattedAddress: formattedAddress,
      street: street,
      district: district,
      city: city,
      country: country,
      postalCode: postalCode,
    );

  factory LocationModel.fromJson(Map<String, dynamic> json) => LocationModel(
      latitude: (json['lat'] as num).toDouble(),
      longitude: (json['lng'] as num).toDouble(),
      pickedAt: DateTime.parse(json['pickedAt'] as String),
      formattedAddress: json['formattedAddress'] as String?,
      street: json['street'] as String?,
      district: json['district'] as String?,
      city: json['city'] as String?,
      country: json['country'] as String?,
      postalCode: json['postalCode'] as String?,
    );

  Map<String, dynamic> toJson() => {
      'lat': latitude,
      'lng': longitude,
      'formattedAddress': formattedAddress,
      'street': street,
      'district': district,
      'city': city,
      'country': country,
      'postalCode': postalCode,
      'pickedAt': pickedAt.toIso8601String(),
    };
}
