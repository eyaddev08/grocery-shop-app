import 'package:dartz/dartz.dart' hide Order;
import 'package:grocery_shop_app/core/error/failure.dart';
import '../entities/order_entity.dart';
import '../repositories/order_repository.dart';

class GetOrdersUseCase {

  GetOrdersUseCase(this.repository);
  final OrderRepository repository;

  Future<Either<Failure, List<OrderEntity>>> call() async => await repository.getOrders();
}
