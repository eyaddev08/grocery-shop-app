part of 'cart_cubit.dart';


enum CartStatus { initial, loading, loaded, error }

class CartState extends Equatable {

  const CartState({
    this.status = CartStatus.initial,
    this.items = const [],
    this.totalPrice = 0.0,
    this.errorMessage = '',
  });
  final CartStatus status;
  final List<CartItemEntity> items;
  final num totalPrice;
  final String errorMessage;

  CartState copyWith({
    CartStatus? status,
    List<CartItemEntity>? items,
    num? totalPrice,
    String? errorMessage,
  }) => CartState(
      status: status ?? this.status,
      items: items ?? this.items,
      totalPrice: totalPrice ?? this.totalPrice,
      errorMessage: errorMessage ?? this.errorMessage,
    );

  @override
  List<Object> get props => [status, items, totalPrice, errorMessage];
}