import '../../../orders/domain/entities/order_entity.dart';

class TrackOrderEntity {
  const TrackOrderEntity({
    required this.orderId,
    required this.deliveryManName,
    required this.deliveryManPhone,
    required this.deliveryAddress,
    required this.deliveryTime,
    required this.distance,
    this.deliveryManImageUrl,
    this.currentLocation,
    this.destinationLocation,
    required this.order,
  });
  final String orderId;
  final String deliveryManName;
  final String deliveryManPhone;
  final String deliveryAddress;
  final String deliveryTime; // e.g., "25 Min"
  final double distance; // e.g., 1.0 km
  final String? deliveryManImageUrl;
  final MapCoordinates? currentLocation;
  final MapCoordinates? destinationLocation;
  final OrderEntity order;
}

class MapCoordinates {
  const MapCoordinates({
    required this.latitude,
    required this.longitude,
  });
  final double latitude;
  final double longitude;
}
