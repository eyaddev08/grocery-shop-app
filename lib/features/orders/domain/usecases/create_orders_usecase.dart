import 'package:dartz/dartz.dart' hide Order;
import '../../../../core/error/failure.dart';
import '../../domain/repositories/order_repository.dart';
import '../../../cart/domain/entities/cart_item.dart';
import '../../domain/entities/order.dart';

class CreateOrderUseCase {
  final OrderRepository repository;

  CreateOrderUseCase(this.repository);

  Future<Either<Failure, void>> call(List<CartItem> items) async {
    try {
      for (final item in items) {
        final order = Order(
          id: DateTime.now().millisecondsSinceEpoch.toString() + item.id,
          productName: item.title,
          price: item.price,
          imageUrl: item.image,
          date:
              DateTime.now().toIso8601String(), // You might want to format this
          status: OrderStatus.active,
          quantity: item.quantity,
          deliveryMessage: 'Order placed',
        );
        final result = await repository.createOrder(order);
        if (result.isLeft()) {
          return result;
        }
      }
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
