import 'package:dartz/dartz.dart' hide Order;
import '../../../../core/error/failure.dart';
import '../../domain/entities/track_order.dart';
import '../../domain/repositories/track_order_repository.dart';
import '../datasources/track_order_remote_data_source.dart';

class TrackOrderRepositoryImpl implements TrackOrderRepository {
  final TrackOrderRemoteDataSource remoteDataSource;

  TrackOrderRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, TrackOrder>> getTrackOrder(String orderId) async {
    try {
      final trackOrder = await remoteDataSource.getTrackOrder(orderId);
      return Right(trackOrder);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
