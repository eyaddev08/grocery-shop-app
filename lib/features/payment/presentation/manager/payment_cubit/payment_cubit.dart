import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entiites/card_info.dart';
import '../../../domain/usecase/tokenize_and_pay.dart';

part 'payment_state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  PaymentCubit({required this.useCase}) : super(const PaymentInitial());
  final TokenizeAndPayUseCase useCase;

  Future<void> tokenizeAndPay(
      {required CardInfo card, required double amount}) async {
    emit(const PaymentLoading());
    final res = await useCase.call(card, amount);
    res.fold(
      (failure) => emit(PaymentFailureState(failure.message)),
      (result) => emit(PaymentSuccess(result)),
    );
  }
}
