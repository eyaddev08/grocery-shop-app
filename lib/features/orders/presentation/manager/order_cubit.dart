import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../cart/domain/entities/cart_item_entity.dart';
import '../../domain/entities/order_entity.dart';
import '../../domain/usecases/cancel_order.dart';
import '../../domain/usecases/create_orders.dart';
import '../../domain/usecases/get_orders.dart';
import 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  OrderCubit(
      {required this.getOrdersUseCase,
      required this.createOrderUseCase,
      required this.cancelOrderUseCase})
      : super(const OrderInitial());
        List<OrderEntity> currentOrders = [];

  final GetOrdersUseCase getOrdersUseCase;
  final CreateOrderUseCase createOrderUseCase;
  final CancelOrderUseCase cancelOrderUseCase;
  void _safeEmit(OrderState state) {
    if (!isClosed) emit(state);
  }

  Future<void> loadOrders() async {
    _safeEmit(const OrderLoading());
    final result = await getOrdersUseCase();
    if (isClosed) return;
    result.fold(
      (failure) => _safeEmit(OrderError(failure.message)),
      (orders) {
        currentOrders = orders;
        _safeEmit(OrderLoaded(orders));
      },
    );
  }

  Future<void> createNewOrder(
      List<CartItemEntity> cartItems) async {
    _safeEmit(OrderActionLoading());
 if (isClosed) return;
    final result = await createOrderUseCase(cartItems);

    result.fold(
      (failure) => _safeEmit(OrderActionError(failure.message)),
      (_) {
        _safeEmit(const OrderActionSuccess('Order created successfully!'));
        loadOrders();
      },
    );
  }

  Future<void> cancelExistingOrder(String orderId) async {
    _safeEmit(OrderActionLoading());
 if (isClosed) return;
    final result = await cancelOrderUseCase(orderId);

    result.fold(
      (failure) {
        _safeEmit(OrderActionError(failure.message));
        _safeEmit(OrderLoaded(currentOrders));
      },
      (_) {
        _safeEmit(const OrderActionSuccess('Order cancelled successfully!'));
      },
    );
  }
}
