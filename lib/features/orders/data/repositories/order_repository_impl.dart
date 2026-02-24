import 'package:dartz/dartz.dart' hide Order;
import 'package:grocery_shop_app/core/error/failure.dart';
import '../../domain/entities/order.dart';
import '../../domain/repositories/order_repository.dart';
import '../datasources/order_local_data_source.dart';
import '../datasources/order_remote_data_source.dart';
import '../models/order_model.dart';

class OrderRepositoryImpl implements OrderRepository {
  final OrderLocalDataSource localDataSource;
  final OrderRemoteDataSource remoteDataSource;

  OrderRepositoryImpl({
    required this.localDataSource,
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, List<Order>>> getOrders() async {
    try {
      final orders = await localDataSource.getOrders();
      return Right(orders);
    } catch (e) {
      return Left(CacheFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> createOrder(Order order) async {
    try {
      final orderModel = OrderModel.fromEntity(order);
      await localDataSource.addOrder(orderModel);
      // Sync with remote
      // await remoteDataSource.syncOrders([orderModel]);
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure(message: e.toString()));
    }
  }
}
