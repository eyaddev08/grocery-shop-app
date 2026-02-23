import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../cart/domain/entities/cart_item.dart';
import '../../../../cart/domain/usecases/clear_cart_usecase.dart';
import '../../../../orders/domain/usecases/create_orders_usecase.dart';
import '../../../domain/entiites/card_info.dart';
import '../../../domain/usecase/tokenize_and_pay.dart';

part 'payment_state.dart';


class PaymentCubit extends Cubit<PaymentState> {
  PaymentCubit({
    required this.useCase,
    required this.createOrderUseCase,
    required this.clearCartUseCase,
  }) : super(const PaymentInitial());

  final TokenizeAndPayUseCase useCase;
  final CreateOrderUseCase createOrderUseCase;
  final ClearCartUseCase clearCartUseCase;

  Future<void> tokenizeAndPay(
      {required CardInfo card,
      required double amount,
      required List<CartItem> items}) async {
    emit(const PaymentLoading());
    final res = await useCase.call(card, amount);
    res.fold(
      (failure) => emit(PaymentFailureState(failure.message)),
      (result) async {
        // Payment success, create order
        final orderRes = await createOrderUseCase.call(items);
        orderRes.fold(
          (failure) => emit(PaymentFailureState(failure.message)),
          (_) async {
            // Order created, clear cart
            final clearRes = await clearCartUseCase.call();
            clearRes.fold(
              (failure) => emit(PaymentFailureState(failure.message)),
              (_) => emit(PaymentSuccess(result)),
            );
          },
        );
      },
    );
  }
}
