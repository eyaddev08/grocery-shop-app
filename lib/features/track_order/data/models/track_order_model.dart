import '../../../orders/data/models/order_model.dart';
import '../../domain/entities/track_order.dart';

class TrackOrderModel extends TrackOrderEntity {
  const TrackOrderModel({
    required super.orderId,
    required super.deliveryManName,
        required super.deliveryManPhone,

    required super.deliveryAddress,
    required super.deliveryTime,
    required super.distance,
    super.deliveryManImageUrl,
    super.currentLocation,
    super.destinationLocation,
    required OrderModel super.order,
  });

  factory TrackOrderModel.fromJson(Map<String, dynamic> json) => TrackOrderModel(
      orderId: json['orderId'] as String,
      deliveryManName: json['delivery_man_name'] as String,
       deliveryManPhone: json['delivery_man_phone'] as String,
      deliveryAddress: json['delivery_address'] as String,
      deliveryTime: json['delivery_time'] as String,
      distance: (json['distance'] as num).toDouble(),
      deliveryManImageUrl: json['delivery_man_imageUrl'] as String?,
      currentLocation: json['current_location'] != null
          ? MapCoordinatesModel.fromJson(
              json['current_location'] as Map<String, dynamic>)
          : null,
      destinationLocation: json['destination_location'] != null
          ? MapCoordinatesModel.fromJson(
              json['destination_location'] as Map<String, dynamic>)
          : null,
      order: OrderModel.fromJson(json['order'] as Map<String, dynamic>),
    );
}

class MapCoordinatesModel extends MapCoordinates {
  const MapCoordinatesModel({
    required super.latitude,
    required super.longitude,
  });

  factory MapCoordinatesModel.fromJson(Map<String, dynamic> json) => MapCoordinatesModel(
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
    );
}

