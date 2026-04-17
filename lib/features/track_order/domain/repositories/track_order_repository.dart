import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../../../orders/domain/entities/order_entity.dart';
import '../entities/track_order.dart';

abstract class TrackOrderRepository {
  Future<Either<Failure, TrackOrderEntity>> getTrackOrder(
      String orderId, OrderEntity order);
}
