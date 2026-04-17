import '../../domain/entities/order_item_entity.dart';

class OrderItemModel extends OrderItemEntity {
  const OrderItemModel({
    required super.productId,
    required super.name,
    required super.price,
    required super.quantity,
    required super.imageUrl,
  });

  factory OrderItemModel.fromJson(Map<String, dynamic> json) => OrderItemModel(
        productId: json['id'] as String,
        name: json['title'] as String,
        price: (json['price'] as num).toDouble(),
        imageUrl: json['image']?.toString() ?? '',
        quantity: json['quantity'] as int,
      );

  factory OrderItemModel.fromEntity(OrderItemEntity entity) => OrderItemModel(
        productId: entity.productId,
        name: entity.name,
        quantity: entity.quantity,
        price: entity.price,
        imageUrl: entity.imageUrl,
      );

  Map<String, dynamic> toJson() => {
        'id': productId,
        'title': name,
        'price': price,
        'image': imageUrl,
        'quantity': quantity,
      };
}
