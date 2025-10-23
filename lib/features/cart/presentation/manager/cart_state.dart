part of 'cart_cubit.dart';


abstract class CartState extends Equatable {
  @override
  List<Object?> get props => [];
}

class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartLoaded extends CartState {
  final List<CartItem> items;
  CartLoaded(this.items);

  @override
  List<Object?> get props => [items];
}

class CartError extends CartState {
  final String message;
  CartError(this.message);

  @override
  List<Object?> get props => [message];
}
