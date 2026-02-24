import '../../domain/entities/track_order.dart';
import '../../../../core/constants/images_constants.dart';
import '../../../orders/domain/entities/order.dart';

abstract class TrackOrderRemoteDataSource {
  Future<TrackOrder> getTrackOrder(String orderId);
}

class TrackOrderRemoteDataSourceImpl implements TrackOrderRemoteDataSource {
  // Mock order data
  final Map<String, Order> _orders = {
    '754634': const Order(
      id: '754634',
      productName: 'Fresh Orange',
      price: 7.90,
      imageUrl: ImagesConstants.orangePixabay,
      date: '02/5/2021',
      status: OrderStatus.active,
      riderName: 'Rakib',
      deliveryMessage: 'Your Oranges are on the way',
      quantity: 1,
    ),
    '754635': const Order(
      id: '754635',
      productName: 'Bananas',
      price: 7.90,
      date: '01/3/2021',
      status: OrderStatus.active,
      quantity: 1,
    ),
    '754636': const Order(
      id: '754636',
      productName: 'Orange',
      price: 7.90,
      date: '07/1/2021',
      status: OrderStatus.success,
      quantity: 1,
    ),
    '754637': const Order(
      id: '754637',
      productName: 'Apple',
      price: 7.90,
      date: '02/5/2021',
      status: OrderStatus.success,
      quantity: 1,
    ),
  };

  @override
  Future<TrackOrder> getTrackOrder(String orderId) async {
    // Simulate network delay
    await Future<void>.delayed(const Duration(milliseconds: 1500));

    // Mock data based on the design
    final order = _orders[orderId] ??
        Order(
            id: orderId,
            productName: 'Unknown Item',
            price: 0.0,
            date: DateTime.now().toIso8601String(),
            status: OrderStatus.active,
            quantity: 1);

    return TrackOrder(
      orderId: orderId,
      deliveryManName: 'Rakibul Hassan',
      deliveryAddress: '37 New line, Sunamganj',
      deliveryTime: '25 Min',
      distance: 1,
      currentLocation: const MapCoordinates(
        latitude: 24.8667,
        longitude: 91.4167,
      ),
      destinationLocation: const MapCoordinates(
        latitude: 24.9000,
        longitude: 91.4200,
      ),
      order: order,
    );
  }
}
