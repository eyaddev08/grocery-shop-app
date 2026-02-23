import 'package:dartz/dartz.dart' hide Order;
import 'package:grocery_shop_app/core/error/failure.dart';
import '../entities/order.dart';

abstract class OrderRepository {
  Future<Either<Failure, List<Order>>> getOrders();
  Future<Either<Failure, void>> createOrder(Order order);
}
