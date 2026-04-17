import 'package:dartz/dartz.dart' hide Order;
import 'package:grocery_shop_app/features/orders/domain/entities/delivery_man_entity.dart';
import '../../../../core/error/failure.dart';
import '../../domain/repositories/order_repository.dart';
import '../../../cart/domain/entities/cart_item_entity.dart';
import '../entities/order_entity.dart';
import '../entities/order_item_entity.dart';

class CreateOrderUseCase {
  CreateOrderUseCase(this.repository);
  final OrderRepository repository;

  Future<Either<Failure, void>> call(List<CartItemEntity> cartItems) async {
    if (cartItems.isEmpty) {
      return Left(
          ServerFailure('Cannot create order with an empty cart.'));
    }

    try {
      final List<OrderItemEntity> orderItems = cartItems
          .map((cartItem) => OrderItemEntity(
                productId: cartItem.id,
                name: cartItem.name,
                price: cartItem.price,
                quantity: cartItem.quantity,
                imageUrl: cartItem.thumbnail,
              ))
          .toList();

      double calculateTotal() => orderItems.fold(
          0, (total, item) => total + (item.price * item.quantity));
      

      final order = OrderEntity(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        createdAt: DateTime.now(),
        status: OrderStatus.active,
        deliveryMessage: 'Order placed',
        totalAmount: calculateTotal() + 3.5,
        items: orderItems,
        deliveryMan: const DeliveryManEntity(
            id: '165842',
            name: 'Rakibul Hassan',
            phone: '7767677404',
            imageUrl: ''),
      );

      return await repository.createOrder(order);
    } catch (e) {
      return Left(ServerFailure(
        'An unexpected error occurred: ${e.toString()}'));
    }
  }
}
