import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../cart/domain/entities/cart_item_entity.dart';
import '../../../../cart/domain/usecases/clear_cart_usecase.dart';
import '../../../../orders/domain/usecases/create_orders.dart';
import '../../../domain/entiites/card_info.dart';
import '../../../domain/usecase/tokenize_and_pay.dart';

part 'payment_state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  PaymentCubit({
    required this.tokenizeAndPayUseCase,
    required this.createOrderUseCase,
    required this.clearCartUseCase,
  }) : super(const PaymentInitial());

  final TokenizeAndPayUseCase tokenizeAndPayUseCase;
  final CreateOrderUseCase createOrderUseCase;
  final ClearCartUseCase clearCartUseCase;

  Future<void> tokenizeAndPay({
    required CardInfo card,
    required double amount,
    required List<CartItemEntity> items,
  }) async {
    emit(const PaymentLoading());

    final paymentRes = await tokenizeAndPayUseCase.call(card, amount);
    dynamic successfulPaymentResult;

    bool hasPaymentFailed = false;
    paymentRes.fold(
      (failure) {
        emit(PaymentFailureState(failure.message));
        hasPaymentFailed = true;
      },
      (result) => successfulPaymentResult = result,
    );

    if (hasPaymentFailed) return;

    final orderRes = await createOrderUseCase.call(items);

    bool hasOrderFailed = false;
    orderRes.fold(
      (failure) {
        emit(PaymentFailureState(failure.message));
        hasOrderFailed = true;
      },
      (_) => null,
    );
    if (hasOrderFailed) return;
    final clearRes = await clearCartUseCase.call();

    clearRes.fold(
      (failure) => emit(PaymentFailureState(failure.message)),
      (_) => emit(PaymentSuccess(successfulPaymentResult as PaymentResult)),
    );
  }
}
