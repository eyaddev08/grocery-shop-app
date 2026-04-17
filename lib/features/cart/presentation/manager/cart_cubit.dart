import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/cart_item_entity.dart';

import '../../domain/usecases/add_to_cart.dart';
import '../../domain/usecases/clear_cart_usecase.dart';
import '../../domain/usecases/get_cart.dart';
import '../../domain/usecases/remove_from_cart.dart';
import '../../domain/usecases/update_quantity.dart';


part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit(
      {required this.getCartUsecase,
      required this.addToCartUsecase,
      required this.clearCartUsecase,
      required this.removeFromCartUsecase,
      required this.updateQuantityUsecase})
      : super(const CartState());
  final GetCartUseCase getCartUsecase;
  final AddToCartUseCase addToCartUsecase;
  final ClearCartUseCase clearCartUsecase;
  final RemoveFromCartUseCase removeFromCartUsecase;
  final UpdateQuantityUseCase updateQuantityUsecase;

  Future<void> loadCart() async {
    emit(state.copyWith(status: CartStatus.loading));
    final result = await getCartUsecase();

    result.fold(
      (failure) => emit(state.copyWith(
          status: CartStatus.error, errorMessage: failure.message)),
      (items) => emit(state.copyWith(
        status: CartStatus.loaded,
        items: items,
        totalPrice: _calculateTotal(items),
      )),
    );
  }

  Future<void> addItem(CartItemEntity item) async {
    final result = await addToCartUsecase(item);

    result.fold(
      (failure) => emit(state.copyWith(
          status: CartStatus.error, errorMessage: failure.message)),
      (_) => loadCart(),
    );
  }

  Future<void> removeFromCart(String productId) async {
    final result = await removeFromCartUsecase(productId);

    result.fold(
      (failure) => emit(state.copyWith(
          status: CartStatus.error, errorMessage: failure.message)),
      (_) => loadCart(),
    );
  }

  Future<void> updateQuantity(String productId, int newQuantity) async {
    final result = await updateQuantityUsecase(productId, newQuantity);

    result.fold(
      (failure) => emit(state.copyWith(
          status: CartStatus.error, errorMessage: failure.message)),
      (l) => loadCart(),
    );
  }

  Future<void> clearCart() async {
    final result = await clearCartUsecase();

    result.fold(
      (failure) => emit(state.copyWith(
          status: CartStatus.error, errorMessage: failure.message)),
      (_) => emit(state.copyWith(
          status: CartStatus.loaded, items: [], totalPrice: 0.0)),
    );
  }

  num _calculateTotal(List<CartItemEntity> items) =>
      items.fold(0.0, (sum, item) => sum + (item.price * item.quantity));
}
