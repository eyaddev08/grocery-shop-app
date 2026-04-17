import '../../domain/entities/delivery_man_entity.dart';

class DeliveryManModel extends DeliveryManEntity {
  const DeliveryManModel({
    required super.id,
    required super.name,
    required super.phone,
    required super.imageUrl,
  });

  factory DeliveryManModel.fromJson(Map<String, dynamic> json) =>
      DeliveryManModel(
        id: json['id']?.toString() ?? '',
        name: json['name']?.toString() ?? '',
        phone: json['phone']?.toString() ?? '',
        imageUrl: json['image']?.toString() ?? '',
      );

  factory DeliveryManModel.fromEntity(DeliveryManEntity entity) =>
      DeliveryManModel(
        id: entity.id,
        name: entity.name,
        phone: entity.phone,
        imageUrl: entity.imageUrl,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'phone': phone,
        'image': imageUrl,
      };
}
