import '../../../orders/domain/entities/order.dart';

class TrackOrder {
  const TrackOrder({
    required this.orderId,
    required this.deliveryManName,
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
  final String deliveryAddress;
  final String deliveryTime; // e.g., "25 Min"
  final double distance; // e.g., 1.0 km
  final String? deliveryManImageUrl;
  final MapCoordinates? currentLocation;
  final MapCoordinates? destinationLocation;
  final Order order;
}

class MapCoordinates {
  const MapCoordinates({
    required this.latitude,
    required this.longitude,
  });
  final double latitude;
  final double longitude;
}
