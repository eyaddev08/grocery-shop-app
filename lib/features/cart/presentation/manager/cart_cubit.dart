import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/cart_item.dart';

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
      : super(CartInitial());
  final GetCartUseCase getCartUsecase;
  final AddToCartUseCase addToCartUsecase;
  final ClearCartUseCase clearCartUsecase;
  final RemoveFromCartUseCase removeFromCartUsecase;
  final UpdateQuantityUseCase updateQuantityUsecase;

  void _safeEmit(CartState s) {
    if (!isClosed) emit(s);
  }

  Future<void> loadCarts() async {
    _safeEmit(CartLoading());
    final res = await getCartUsecase();
    res.fold((error) => _safeEmit(CartError(error.message)), (cart) {
      if (cart.isEmpty) {
        _safeEmit(CartEmpty());
      } else {
        _safeEmit(CartLoaded(cart));
      }
    });
  }

  Future<void> addItem(CartItem item) async {
    final res = await addToCartUsecase(item);
    res.fold((error) => _safeEmit(CartError(error.message)),
        (r) => _safeEmit(CartLoaded(r)));
  }

  Future<void> removeItem(String id) async {
    final res = await removeFromCartUsecase(id);
    res.fold((error) => _safeEmit(CartError(error.message)),
        (r) => _safeEmit(CartLoaded(r)));
  }

  Future<void> clearCart() async {
    await clearCartUsecase();
    await loadCarts();
  }

  Future<void> updateQuantity(String id, int quantity) async {
    final res = await updateQuantityUsecase(id, quantity);
    res.fold((error) => _safeEmit(CartError(error.message)),
        (r) => _safeEmit(CartLoaded(r)));
  }
}
