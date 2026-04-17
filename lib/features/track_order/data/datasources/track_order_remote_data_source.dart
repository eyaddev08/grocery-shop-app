import '../../../orders/data/models/order_model.dart';
import '../../../orders/domain/entities/order_entity.dart';
import '../models/track_order_model.dart';

abstract class TrackOrderRemoteDataSource {
  Future<TrackOrderModel> getTrackOrder(String orderId, OrderEntity order);
}

class TrackOrderRemoteDataSourceImpl implements TrackOrderRemoteDataSource {
  @override
  Future<TrackOrderModel> getTrackOrder(
      String orderId, OrderEntity order) async {
    await Future<void>.delayed(const Duration(milliseconds: 1500));

    return TrackOrderModel(
      orderId: orderId,
      deliveryManName: order.deliveryMan?.name ?? '',
      deliveryManPhone: order.deliveryMan?.phone ?? '',
      deliveryManImageUrl: '',
      deliveryAddress: '37 New line, Sunamganj',
      deliveryTime: '25 Min',
      distance: 1,
      currentLocation: const MapCoordinatesModel(
        latitude: 24.8667,
        longitude: 91.4167,
      ),
      destinationLocation: const MapCoordinatesModel(
        latitude: 24.9000,
        longitude: 91.4200,
      ),
      order: OrderModel(
        id: orderId,
        createdAt: order.createdAt,
        status: order.status,
        totalAmount: order.totalAmount,
        deliveryMessage: order.deliveryMessage,
        items: order.items,
        deliveryMan: order.deliveryMan
      ),
    );
  }
}
