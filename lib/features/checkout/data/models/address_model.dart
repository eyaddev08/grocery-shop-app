import 'package:hive/hive.dart';
import '../../domain/entities/address_entity.dart';

part 'address_model.g.dart';

@HiveType(typeId: 3)
class AddressModel extends AddressEntity {
  @HiveField(0)
  @override
  final String id;
  @HiveField(1)
  @override
  final String label;
  @HiveField(2)
  @override
  final String details;
  @HiveField(3)
  @override
  final bool isDefault;
  @HiveField(4)
  @override
  final String addressType;
  @HiveField(5)
  @override
  final String? address;
  @HiveField(6)
  @override
  final String? city;
  @HiveField(7)
  @override
  final String? createdAt;
  @HiveField(8)
  @override
  final String? updatedAt;
  @HiveField(9)
  @override
  final String? state;
  @HiveField(10)
  @override
  final String? country;
  @HiveField(11)
  @override
  final String? latitude;
  @HiveField(12)
  @override
  final String? longitude;
  @HiveField(13)
  @override
  final bool? isBilling;
  @HiveField(14)
  @override
  final String? street;
  @HiveField(15)
  @override
  final String? postalCode;
  @HiveField(16)
  @override
  final String? region;

  AddressModel({
    required this.id,
    required this.label,
    required this.details,
    this.isDefault = false,
    required this.addressType,
    this.address,
    this.city,
    this.createdAt,
    this.updatedAt,
    this.state,
    this.country,
    this.latitude,
    this.longitude,
    this.isBilling,
    this.street,
    this.postalCode,
    this.region,
  })  : super(
          id: id,
          label: label,
          details: details,
          isDefault: isDefault,
          addressType: addressType,
          address: address,
          city: city,
          createdAt: createdAt,
          updatedAt: updatedAt,
          state: state,
          country: country,
          latitude: latitude,
          longitude: longitude,
          isBilling: isBilling,
          street: street,
          postalCode: postalCode,
          region: region,
        );
  factory AddressModel.fromJson(Map<String, dynamic> json) => AddressModel(
        id: json['id'] as String,
        label: json['label'] as String,
        details: json['details'] as String,
        isDefault: json['is_default'] as bool? ?? false,
        addressType: json['address_type'] as String,
        address: json['address'] as String?,
        city: json['city'] as String?,
        createdAt: json['created_at'] as String?,
        updatedAt: json['updated_at'] as String?,
        state: json['state'] as String?,
        country: json['country'] as String?,
        latitude: json['latitude'] as String?,
        longitude: json['longitude'] as String?,
        isBilling: json['is_billing'] as bool?,
        street: json['street'] as String?,
        postalCode: json['postal_code'] as String?,
        region: json['region'] as String?,
      );
  factory AddressModel.fromEntity(AddressEntity entity) => AddressModel(
        id: entity.id,
        label: entity.label,
        details: entity.details,
        isDefault: entity.isDefault,
        addressType: entity.addressType,
        address: entity.address,
        city: entity.city,
        createdAt: entity.createdAt,
        updatedAt: entity.updatedAt,
        state: entity.state,
        country: entity.country,
        latitude: entity.latitude,
        longitude: entity.longitude,
        isBilling: entity.isBilling,
        street: entity.street,
        postalCode: entity.postalCode,
        region: entity.region,
      );
  Map<String, dynamic> toJson() => {
        'id': id,
        'label': label,
        'details': details,
        'is_default': isDefault,
        'address_type': addressType,
        'address': address,
        'city': city,
        'created_at': createdAt,
        'updated_at': updatedAt,
        'state': state,
        'country': country,
        'latitude': latitude,
        'longitude': longitude,
        'is_billing': isBilling,
        'street': street,
        'postal_code': postalCode,
        'region': region,
      };

  AddressEntity toEntity() => AddressEntity(
        id: id,
        label: label,
        details: details,
        isDefault: isDefault,
        addressType: addressType,
        address: address,
        city: city,
        createdAt: createdAt,
        updatedAt: updatedAt,
        state: state,
        country: country,
        latitude: latitude,
        longitude: longitude,
        isBilling: isBilling,
        street: street,
        postalCode: postalCode,
        region: region,
      );
}
