
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/cart_item.dart';

import '../../domain/usecases/add_to_cart.dart';
import '../../domain/usecases/get_cart.dart';
import '../../domain/usecases/remove_from_cart.dart';
import '../../domain/usecases/update_quantity.dart';

part 'cart_state.dart';


class CartCubit extends Cubit<CartState> {
  final GetCart getCartUsecase;
  final AddToCart addToCartUsecase;
  final RemoveFromCart removeFromCartUsecase;
  final UpdateQuantity updateQuantityUsecase;

  CartCubit(
      {required this.getCartUsecase,
      required this.addToCartUsecase,
      required this.removeFromCartUsecase,
      required this.updateQuantityUsecase})
      : super(CartInitial());

  void _safeEmit(CartState s) {
    if (!isClosed) emit(s);
  }

  Future<void> load() async {
    _safeEmit(CartLoading());
    final res = await getCartUsecase();
    res.fold((l) => _safeEmit(CartError(l.message)),
        (r) => _safeEmit(CartLoaded(r)));
  }

  Future<void> addItem(CartItem item) async {
    final res = await addToCartUsecase(item);
    res.fold((l) => _safeEmit(CartError(l.message)),
        (r) => _safeEmit(CartLoaded(r)));
  }

  Future<void> removeItem(String id) async {
    final res = await removeFromCartUsecase(id);
    res.fold((l) => _safeEmit(CartError(l.message)),
        (r) => _safeEmit(CartLoaded(r)));
  }

  Future<void> updateQuantity(String id, int quantity) async {
    final res = await updateQuantityUsecase(id, quantity);
    res.fold((l) => _safeEmit(CartError(l.message)),
        (r) => _safeEmit(CartLoaded(r)));
  }
}
