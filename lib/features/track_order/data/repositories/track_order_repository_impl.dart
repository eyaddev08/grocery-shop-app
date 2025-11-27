import 'package:dartz/dartz.dart' hide Order;
import '../../../../core/error/failure.dart';
import '../../domain/entities/track_order.dart';
import '../../domain/repositories/track_order_repository.dart';
import '../../../orders/domain/entities/order.dart';

class TrackOrderRepositoryImpl implements TrackOrderRepository {
  // Mock order data
  final Map<String, Order> _orders = {
    '754634': const Order(
      id: '754634',
      productName: 'Fresh Orange',
      price: 7.90,
      date: '02/10/2021',
      status: OrderStatus.active,
      riderName: 'Rakibul Hassan',
      deliveryMessage: 'Your Oranges are on the way',
    ),

      '754635':  const Order(
      id: '754635',
      productName: 'Bananas',
      price: 7.90,
      date: '01/3/2021',
      status: OrderStatus.active,
    ),
     '754636':  const Order(
      id: '754636',
      productName: 'Orange',
      price: 7.90,
      date: '07/1/2021',
      status: OrderStatus.success,
    ),
     '754637':  const Order(
      id: '754637',
      productName: 'Apple',
      price: 7.90,
      date: '02/5/2021',
      status: OrderStatus.success,
    ),
  };

  @override
  Future<Either<Failure, TrackOrder>> getTrackOrder(String orderId) async {
    // Simulate network delay
    await Future<void>.delayed(const Duration(microseconds: 1500));

    // Mock data based on the design
    try {
      final order = _orders[orderId];

      final trackOrder = TrackOrder(
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

      return Right(trackOrder);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
