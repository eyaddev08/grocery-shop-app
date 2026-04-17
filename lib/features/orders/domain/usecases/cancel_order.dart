import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../repositories/order_repository.dart';

class CancelOrderUseCase {
  
  CancelOrderUseCase(this.repository);
  final OrderRepository repository;

  Future<Either<Failure, void>> call(String orderId) async => await repository.cancelOrder(orderId);
}