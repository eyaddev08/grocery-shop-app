import '../../domain/entities/profile_entity.dart';

class ProfileModel extends ProfileEntity {
  const ProfileModel({
    required super.id,
    required super.name,
    required super.email,
    super.phone,
    super.address,
    super.avatarUrl,
    super.createdAt,
  });

  factory ProfileModel.fromEntity(ProfileEntity entity) => ProfileModel(
        id: entity.id,
        name: entity.name,
        email: entity.email,
        phone: entity.phone,
        address: entity.address,
        avatarUrl: entity.avatarUrl,
        createdAt: entity.createdAt,
      );

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
        id: json['id'] as String,
        name: json['name'] as String,
        email: json['email'] as String,
        phone: json['phone'] as String?,
        address: json['address'] != null
            ? UserAddressModel.fromJson(json['address'] as Map<String, dynamic>)
            : null,
        avatarUrl: json['avatar_url'] as String?,
        createdAt: json['created_at'] != null
            ? DateTime.parse(json['created_at'] as String)
            : null,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'phone': phone,
        'address': address != null
            ? UserAddressModel.fromEntity(address!).toJson()
            : null,
        'avatar_url': avatarUrl,
        'created_at': createdAt?.toIso8601String(),
      };

  ProfileEntity toEntity() => this;
}

class UserAddressModel extends UserAddress {
  const UserAddressModel({
    super.street,
    super.city,
    super.region,
    super.postalCode,
    super.country,
  });

  factory UserAddressModel.fromEntity(UserAddress entity) => UserAddressModel(
        street: entity.street,
        city: entity.city,
        region: entity.region,
        postalCode: entity.postalCode,
        country: entity.country,
      );

  factory UserAddressModel.fromJson(Map<String, dynamic> json) =>
      UserAddressModel(
        street: json['street'] as String?,
        city: json['city'] as String?,
        region: json['region'] as String?,
        postalCode: json['postal_code'] as String?,
        country: json['country'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'street': street,
        'city': city,
        'region': region,
        'postal_code': postalCode,
        'country': country,
      };

  UserAddress toEntity() => this;
}
