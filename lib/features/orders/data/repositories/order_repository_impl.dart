import 'package:dartz/dartz.dart' hide Order;
import 'package:grocery_shop_app/core/error/failure.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/order_entity.dart';
import '../../domain/repositories/order_repository.dart';
import '../datasources/order_local_data_source.dart';
import '../datasources/order_remote_data_source.dart';
import '../models/order_model.dart';

class OrderRepositoryImpl implements OrderRepository {
  OrderRepositoryImpl({
    required this.localDataSource,
    required this.remoteDataSource,
    required this.networkInfo,
  });
  final OrderLocalDataSource localDataSource;
  final OrderRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  @override
  Future<Either<Failure, List<OrderEntity>>> getOrders() async {
    try {
      if (await networkInfo.isConnected) {
        // final remoteOrders = await remoteDataSource.getOrders();
      }
      final orders = await localDataSource.getOrders();
      return Right(orders);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> createOrder(
      OrderEntity order) async {
    try {
      final orderModel = OrderModel.fromEntity(order);
   
      if (await networkInfo.isConnected) {
        await remoteDataSource.createOrders(orderModel);
      }
      await localDataSource.addOrder(orderModel);
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure( e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> cancelOrder(String orderId) async {
    try {
      if (await networkInfo.isConnected) {
        await remoteDataSource.cancelOrder(orderId);
      }

      await localDataSource.updateOrderStatusToCancelled(orderId);

      return const Right(null);
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }
}
