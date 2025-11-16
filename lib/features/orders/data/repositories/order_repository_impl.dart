import 'package:dartz/dartz.dart' hide Order;
import 'package:grocery_shop_app/core/error/failure.dart';
import '../../domain/entities/order.dart';
import '../../domain/repositories/order_repository.dart';

class OrderRepositoryImpl implements OrderRepository {
  final List<Order> _orders = [
    const Order(
      id: '765433',
      productName: 'Fresh Orange',
      price: 7.90,
      imageUrl: null,
      date: '02/10/2021',
      status: OrderStatus.active,
      riderName: 'Rakib',
      deliveryMessage: 'Your Oranges are on the way',
    ),
    const Order(
      id: '765433',
      productName: 'Bananas',
      price: 7.90,
      imageUrl: null,
      date: '02/10/2021',
      status: OrderStatus.success,
    ),
    const Order(
      id: '765433',
      productName: 'Orange',
      price: 7.90,
      imageUrl: null,
      date: '02/10/2021',
      status: OrderStatus.success,
    ),
    const Order(
      id: '765433',
      productName: 'Apple',
      price: 7.90,
      imageUrl: null,
      date: '02/10/2021',
      status: OrderStatus.success,
    ),
  ];

  @override
  Future<Either<Failure, List<Order>>> getOrders() async {
    await Future<void>.delayed(const Duration(milliseconds: 800));
    return Right(List.unmodifiable(_orders));
  }
}
