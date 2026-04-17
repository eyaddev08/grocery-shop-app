import 'package:equatable/equatable.dart';
import '../../domain/entities/order_entity.dart';

abstract class OrderState extends Equatable {
  const OrderState();

  @override
  List<Object?> get props => [];
}

class OrderInitial extends OrderState {
  const OrderInitial();
}

class OrderLoading extends OrderState {
  const OrderLoading();
}

class OrderLoaded extends OrderState {
  const OrderLoaded(this.orders);
  final List<OrderEntity> orders;

  @override
  List<Object?> get props => [orders];
}

class OrderError extends OrderState {
  const OrderError(this.message);
  final String message;

  @override
  List<Object?> get props => [message];
}


class OrderActionLoading extends OrderState {}

class OrderActionSuccess extends OrderState {
  const OrderActionSuccess(this.message);
  final String message;
  @override
  List<Object> get props => [message];
}

class OrderActionError extends OrderState {
  const OrderActionError(this.message);
  final String message;
  @override
  List<Object> get props => [message];
}
