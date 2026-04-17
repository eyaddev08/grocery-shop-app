import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../../../orders/domain/entities/order_entity.dart';
import '../entities/track_order.dart';
import '../repositories/track_order_repository.dart';

class GetTrackOrderUseCase {

  GetTrackOrderUseCase(this.repository);
  final TrackOrderRepository repository;

  Future<Either<Failure, TrackOrderEntity>> call(String orderId, OrderEntity order) async => repository.getTrackOrder(orderId, order);
}