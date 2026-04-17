class AddressEntity {
  AddressEntity({
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
      this.region
  });
  final String id;
  final String label;
  final String details;
  final bool isDefault;
  final String addressType;

  final String? address;
  final String? city;
  final String? createdAt;
  final String? updatedAt;
  final String? state;
  final String? country;
  final String? latitude;
  final String? longitude;
  final bool? isBilling;
  final String? street;
  final String? postalCode;
  final String? region;

  AddressEntity copyWith({
    String? id,
    String? label,
    String? details,
    bool? isDefault,
    String? addressType,
    String? address,
    String? city,
    String? createdAt,
    String? updatedAt,
    String? state,
    String? country,
    String? latitude,
    String? longitude,
    bool? isBilling,
      String? street,
      String? postalCode,
      String? region
  }) =>
      AddressEntity(
        id: id ?? this.id,
        label: label ?? this.label,
        details: details ?? this.details,
        isDefault: isDefault ?? this.isDefault,
        addressType: addressType ?? this.addressType,
        address: address ?? this.address,
        city: city ?? this.city,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.createdAt,
        state: state ?? this.state,
        country: country ?? this.country,
        latitude: latitude ?? this.latitude,
        longitude: longitude ?? this.longitude,
        isBilling: isBilling ?? this.isBilling,
        street: street ?? this.street,
        postalCode: postalCode ?? this.postalCode,
        region: region ?? this.region
      );
}
