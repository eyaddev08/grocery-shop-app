import '../models/order_model.dart';

abstract class OrderRemoteDataSource {
  Future<void> syncOrders(List<OrderModel> orders);
}

class OrderRemoteDataSourceImpl implements OrderRemoteDataSource {
  @override
  Future<void> syncOrders(List<OrderModel> orders) async {
    await Future<void>.delayed(const Duration(seconds: 1));
    // Implementation for syncing with backend would go here.
  }
}
