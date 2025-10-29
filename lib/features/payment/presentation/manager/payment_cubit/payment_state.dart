part of 'payment_cubit.dart';

abstract class PaymentState extends Equatable {
  const PaymentState();
  @override
  List<Object?> get props => [];
}

class PaymentInitial extends PaymentState {
  const PaymentInitial();
}

class PaymentLoading extends PaymentState {
  const PaymentLoading();
}

class PaymentSuccess extends PaymentState {
  const PaymentSuccess(this.result);
  final PaymentResult result;
  @override
  List<Object?> get props => [result.transactionId, result.amount];
}

class PaymentFailureState extends PaymentState {
  const PaymentFailureState(this.message);
  final String message;
  @override
  List<Object?> get props => [message];
}
