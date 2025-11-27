import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../entities/track_order.dart';
import '../repositories/track_order_repository.dart';

class GetTrackOrder {
  final TrackOrderRepository repository;

  GetTrackOrder(this.repository);

  Future<Either<Failure, TrackOrder>> call(String orderId) async {
    return await repository.getTrackOrder(orderId);
  }
}
