import 'delivery_man_entity.dart';
import 'order_item_entity.dart';

class OrderEntity {

  const OrderEntity( {
    required this.id,
    required this.createdAt,
    required this.status,
    this.riderName,
    this.deliveryMessage,
    required this.totalAmount,
    required this.items,
     this.deliveryMan,
    this.paymentStatus, this.paymentMethod, this.paymentBy, this.paymentNote
  });
  final String id;

  final DateTime createdAt;
  final OrderStatus status;
  final String? riderName;
  final String? deliveryMessage;
  final double totalAmount; 
  final List<OrderItemEntity> items;
  final DeliveryManEntity? deliveryMan;
    final String? paymentStatus;
  final String? paymentMethod;
  final String? paymentBy;
  final String? paymentNote;
}

enum OrderStatus {pending, active,
  success,
  cancelled,  processing, shipped,   }


