import 'package:dartz/dartz.dart';
import 'package:grocery_shop_app/core/error/failure.dart';
import '../../domain/entities/cart_item.dart';
import '../../domain/repositories/cart_repository.dart';

class CartRepositoryImpl implements CartRepository {
  final List<CartItem> _items = [];

  @override
  Future<Either<Failure, List<CartItem>>> addItem(CartItem item) async {
    await Future<void>.delayed(const Duration(milliseconds: 200));
    final idx = _items.indexWhere((e) => e.id == item.id);
    if (idx >= 0) {
      final existing = _items[idx];
      _items[idx] = CartItem(
          id: existing.id,
          title: existing.title,
          price: existing.price,
          regularPrice: existing.regularPrice,
          quantity: existing.quantity + item.quantity,
          image: existing.image);
    } else {
      _items.add(item);
    }
    return Right(List.unmodifiable(_items));
  }

  @override
  Future<Either<Failure, List<CartItem>>> getCart() async {
    await Future<void>.delayed(const Duration(milliseconds: 150));
    return Right(List.unmodifiable(_items));
  }

  @override
  Future<Either<Failure, List<CartItem>>> removeItem(String id) async {
    await Future<void>.delayed(const Duration(milliseconds: 150));
    _items.removeWhere((e) => e.id == id);
    return Right(List.unmodifiable(_items));
  }

  @override
  Future<Either<Failure, List<CartItem>>> updateQuantity(
      String id, int quantity) async {
    await Future<void>.delayed(const Duration(milliseconds: 150));
    final idx = _items.indexWhere((e) => e.id == id);
    if (idx >= 0) {
      final e = _items[idx];
      _items[idx] = CartItem(
          id: e.id,
          title: e.title,
          price: e.price,
          regularPrice: e.regularPrice,
          quantity: quantity,
          image: e.image);
    }
    return Right(List.unmodifiable(_items));
  }
}
