import 'package:dartz/dartz.dart' hide Order;
import 'package:grocery_shop_app/features/orders/domain/entities/order_entity.dart';
import '../../../../core/error/exception.dart';
import '../../../../core/error/failure.dart';
import '../../domain/entities/track_order.dart';
import '../../domain/repositories/track_order_repository.dart';
import '../datasources/track_order_remote_data_source.dart';

class TrackOrderRepositoryImpl implements TrackOrderRepository {

  TrackOrderRepositoryImpl({required this.remoteDataSource});
  final TrackOrderRemoteDataSource remoteDataSource;

  @override
  Future<Either<Failure, TrackOrderEntity>> getTrackOrder(
      String orderId, OrderEntity order) async {
    try {
      final trackOrderModel =
          await remoteDataSource.getTrackOrder(orderId, order);
      return Right(trackOrderModel);
    } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      }
  }
}
