import 'package:equatable/equatable.dart';

class ProfileEntity extends Equatable {

  const ProfileEntity({
    required this.id,
    required this.name,
    required this.email,
    this.phone,
    this.address,
    this.avatarUrl,
    this.createdAt,
  });
  final String id;
  final String name;
  final String email;
  final String? phone;
  final UserAddress? address;
  final String? avatarUrl;
  final DateTime? createdAt;

  @override
  List<Object?> get props => [id, name, email, phone, address, avatarUrl, createdAt];
}
class UserAddress extends Equatable {
  final String? street;
  final String? city;
  final String? region;
  final String? postalCode;
  final String? country;

  const UserAddress({
    this.street,
    this.city,
    this.region,
    this.postalCode,
    this.country,
  });

  

  

  @override
  List<Object?> get props => [street, city, region, postalCode, country];
}