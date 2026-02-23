import '../../domain/entities/order.dart';

class OrderModel extends Order {
  const OrderModel({
    required super.id,
    required super.productName,
    required super.price,
    super.imageUrl,
    required super.date,
    required super.status,
    super.riderName,
    super.deliveryMessage,
    required super.quantity,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'] as String,
      productName: json['productName'] as String,
      price: (json['price'] as num).toDouble(),
      imageUrl: json['imageUrl'] as String?,
      date: json['date'] as String,
      status: OrderStatus.values.firstWhere(
        (e) => e.name == json['status'],
        orElse: () => OrderStatus.active,
      ),
      riderName: json['riderName'] as String?,
      deliveryMessage: json['deliveryMessage'] as String?,
      quantity: json['quantity'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'productName': productName,
      'price': price,
      'imageUrl': imageUrl,
      'date': date,
      'status': status.name,
      'riderName': riderName,
      'deliveryMessage': deliveryMessage,
      'quantity': quantity,
    };
  }

  factory OrderModel.fromEntity(Order order) {
    return OrderModel(
      id: order.id,
      productName: order.productName,
      price: order.price,
      imageUrl: order.imageUrl,
      date: order.date,
      status: order.status,
      riderName: order.riderName,
      deliveryMessage: order.deliveryMessage,
      quantity: order.quantity,
    );
  }
}
