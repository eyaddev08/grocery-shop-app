import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../entities/track_order.dart';

abstract class TrackOrderRepository {
  Future<Either<Failure, TrackOrder>> getTrackOrder(String orderId);
}
