import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/error/failure.dart';
import '../../domain/entities/track_order.dart';
import '../../domain/usecases/get_track_order.dart';
import 'track_order_state.dart';

class TrackOrderCubit extends Cubit<TrackOrderState> {
  final GetTrackOrder getTrackOrderUseCase;

  TrackOrderCubit({required this.getTrackOrderUseCase})
      : super(const TrackOrderInitial());

  void _safeEmit(TrackOrderState state) {
    if (!isClosed) emit(state);
  }

  Future<void> loadTrackOrder(String orderId) async {
    _safeEmit(const TrackOrderLoading());
    final Either<Failure, TrackOrder> result =
        await getTrackOrderUseCase(orderId);
    if (isClosed) return;
    result.fold(
      (failure) => _safeEmit(TrackOrderError(failure.message)),
      (trackOrder) => _safeEmit(TrackOrderLoaded(trackOrder)),
    );
  }
}
