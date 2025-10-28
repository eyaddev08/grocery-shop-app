import '../../domain/entities/address.dart';

abstract class CheckoutState {}

class CheckoutInitial extends CheckoutState {}

class CheckoutLoading extends CheckoutState {}

class CheckoutLoaded extends CheckoutState {
  CheckoutLoaded(this.addresses);
  final List<Address> addresses;
}

class CheckoutEmpty extends CheckoutState {}

class CheckoutError extends CheckoutState {
  CheckoutError(this.message);
  final String message;
}
