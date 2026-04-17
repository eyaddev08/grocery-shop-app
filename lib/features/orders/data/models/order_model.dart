import '../../domain/entities/order_entity.dart';
import 'delivery_man_model.dart';
import 'order_item_model.dart';

class OrderModel extends OrderEntity {
  OrderModel(
      {required super.id,
      required super.createdAt,
      required super.status,
      super.riderName,
      super.deliveryMessage,
      required super.items,
      super.deliveryMan,
      required super.totalAmount,
      super.paymentBy,
      super.paymentStatus,
      super.paymentMethod,
      super.paymentNote});

  factory OrderModel.fromEntity(OrderEntity order) => OrderModel(
      id: order.id,
      createdAt: order.createdAt,
      status: order.status,
      riderName: order.riderName,
      deliveryMessage: order.deliveryMessage,
      items: order.items,
      deliveryMan: order.deliveryMan,
      totalAmount: order.totalAmount,
      paymentBy: order.paymentBy,
      paymentMethod: order.paymentMethod,
      paymentStatus: order.paymentStatus,
      paymentNote: order.paymentNote);

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
        id: json['id'] as String,
        totalAmount: (json['total_amount'] as num?)?.toDouble() ?? 0.0,
        createdAt: DateTime.tryParse(json['created_at']?.toString() ?? '') ??
            DateTime.now(),
        items: (json['items'] as List?)
                ?.map((e) => OrderItemModel.fromJson(e as Map<String, dynamic>))
                .toList() ??
            [],
        deliveryMan: json['delivery_man'] != null
            ? DeliveryManModel.fromJson(
                json['delivery_man'] as Map<String, dynamic>)
            : null,
        status: OrderStatus.values.firstWhere(
          (e) => e.name == json['status'],
          orElse: () => OrderStatus.active,
        ),
        riderName: json['riderName'] as String?,
        deliveryMessage: json['deliveryMessage'] as String?,
        paymentStatus: json['payment_status'] as String?,
        paymentMethod: json['payment_method'] as String?,
        paymentBy: json['payment_by'] as String?,
        paymentNote: json['payment_note'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'created_at': createdAt.toIso8601String(),
        'status': status.name,
        'rider_name': riderName,
        'delivery_message': deliveryMessage,
        'items': items
            .map((item) => OrderItemModel.fromEntity(item).toJson())
            .toList(),
        'delivery_man': deliveryMan != null
            ? DeliveryManModel.fromEntity(deliveryMan!).toJson()
            : null,
        'total_amount': totalAmount,
        'paymentBy': paymentBy,
        'paymentMethod': paymentMethod,
        'paymentStatus': paymentStatus,
      };
}
