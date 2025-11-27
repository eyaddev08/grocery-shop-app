import 'package:equatable/equatable.dart';
import '../../domain/entities/track_order.dart';

abstract class TrackOrderState extends Equatable {
  const TrackOrderState();

  @override
  List<Object?> get props => [];
}

class TrackOrderInitial extends TrackOrderState {
  const TrackOrderInitial();
}

class TrackOrderLoading extends TrackOrderState {
  const TrackOrderLoading();
}

class TrackOrderLoaded extends TrackOrderState {
  final TrackOrder trackOrder;

  const TrackOrderLoaded(this.trackOrder);

  @override
  List<Object?> get props => [trackOrder];
}

class TrackOrderError extends TrackOrderState {
  final String message;

  const TrackOrderError(this.message);

  @override
  List<Object?> get props => [message];
}
