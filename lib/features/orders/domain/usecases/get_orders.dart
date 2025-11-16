import 'package:dartz/dartz.dart' hide Order;
import 'package:grocery_shop_app/core/error/failure.dart';
import '../entities/order.dart';
import '../repositories/order_repository.dart';

class GetOrders {
  final OrderRepository repository;

  GetOrders(this.repository);

  Future<Either<Failure, List<Order>>> call() async {
    return await repository.getOrders();
  }
}
