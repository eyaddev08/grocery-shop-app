import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/error/failure.dart';
import '../../../orders/domain/entities/order_entity.dart';
import '../../domain/entities/track_order.dart';
import '../../domain/usecases/get_track_order.dart';
import 'track_order_state.dart';

class TrackOrderCubit extends Cubit<TrackOrderState> {
  TrackOrderCubit({required this.getTrackOrderUseCase})
      : super(const TrackOrderInitial());
  final GetTrackOrderUseCase getTrackOrderUseCase;

  void _safeEmit(TrackOrderState state) {
    if (!isClosed) emit(state);
  }

  Future<void> loadTrackOrder(String orderId, OrderEntity order) async {
    _safeEmit(const TrackOrderLoading());
    final Either<Failure, TrackOrderEntity> result =
        await getTrackOrderUseCase(orderId, order);
    if (isClosed) return;
    result.fold(
      (failure) => _safeEmit(TrackOrderError(failure.message)),
      (trackOrder) => _safeEmit(TrackOrderLoaded(trackOrder)),
    );
  }
}
