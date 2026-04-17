import 'dart:convert';

import 'package:grocery_shop_app/features/orders/domain/entities/order_entity.dart';
import 'package:hive/hive.dart';

import '../models/order_model.dart';

abstract class OrderLocalDataSource {
  Future<List<OrderModel>> getOrders();
  Future<void> cacheOrders(List<OrderModel> orders);
  Future<void> addOrder(OrderModel order);
  Future<void> updateOrderStatusToCancelled(String orderId);
}

class OrderLocalDataSourceImpl implements OrderLocalDataSource {
  OrderLocalDataSourceImpl({required this.box});
  final Box<String> box;
  static const String _kOrdersKey = 'cached_orders';

  @override
  Future<void> addOrder(OrderModel order) async {
    final List<OrderModel> currentOrders = await getOrders();
    currentOrders.add(order);
    await cacheOrders(currentOrders);
  }

  @override
  Future<void> cacheOrders(List<OrderModel> orders) async {
    final List<Map<String, dynamic>> jsonList =
        orders.map((e) => e.toJson()).toList();
    await box.put(_kOrdersKey, jsonEncode(jsonList));
  }

  @override
  Future<List<OrderModel>> getOrders() async {
    final jsonString = box.get(_kOrdersKey);
    if (jsonString != null) {
      final List<dynamic> jsonList = jsonDecode(jsonString) as List<dynamic>;
      return jsonList
          .map((e) => OrderModel.fromJson(e as Map<String, dynamic>))
          .toList();
    }
    return [];
  }

  @override
  Future<void> updateOrderStatusToCancelled(String orderId) async {
    final List<OrderModel> currentOrders = await getOrders();
    final updatedOrders = currentOrders.map((order) {
      if (order.id == orderId) {
        return OrderModel(
          id: order.id,
          status: OrderStatus.cancelled,
          createdAt: order.createdAt,
          totalAmount: order.totalAmount,
          items: order.items,
          deliveryMan: order.deliveryMan
        );
      }
      return order;
    }).toList();
    await cacheOrders(updatedOrders);
  }
}
