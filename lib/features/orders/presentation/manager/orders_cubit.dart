import 'package:dartz/dartz.dart' hide Order;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_shop_app/core/error/failure.dart';
import '../../domain/entities/order.dart';
import '../../domain/usecases/get_orders.dart';
import 'orders_state.dart';

class OrdersCubit extends Cubit<OrdersState> {
  final GetOrders getOrdersUseCase;

  OrdersCubit({required this.getOrdersUseCase}) : super(const OrdersInitial());

  void _safeEmit(OrdersState state) {
    if (!isClosed) emit(state);
  }

  Future<void> loadOrders() async {
    _safeEmit(const OrdersLoading());
    final Either<Failure, List<Order>> result = await getOrdersUseCase();
    if (isClosed) return;
    result.fold(
      (failure) => _safeEmit(OrdersError(failure.message)),
      (orders) => _safeEmit(OrdersLoaded(orders)),
    );
  }
}
