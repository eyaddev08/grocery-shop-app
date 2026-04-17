import 'package:dio/dio.dart';
import '../models/order_model.dart';

abstract class OrderRemoteDataSource {
  Future<List<OrderModel>> getOrders();
  Future<void> createOrders(OrderModel orders);
  Future<void> cancelOrder(String orderId);
}

class OrderRemoteDataSourceImpl implements OrderRemoteDataSource {
  OrderRemoteDataSourceImpl({required this.client});

  final Dio client;
  @override
  Future<List<OrderModel>> getOrders() async {
    await Future<void>.delayed(const Duration(seconds: 1));
    return [];
  }

  @override
  Future<void> createOrders(OrderModel orders) async {
    await Future<void>.delayed(const Duration(seconds: 1));
    return;
  }

  @override
  Future<void> cancelOrder(String orderId) async {
    await Future<void>.delayed(const Duration(seconds: 1));
    return;
  }
}
