import 'package:dartz/dartz.dart';
import 'package:grocery_shop_app/core/error/failure.dart';
import '../entities/cart_item.dart';

abstract class CartRepository {
  Future<Either<Failure, List<CartItem>>> getCart();
  Future<Either<Failure, List<CartItem>>> addItem(CartItem item);
  Future<Either<Failure, List<CartItem>>> removeItem(String id);
  Future<Either<Failure, List<CartItem>>> updateQuantity(
      String id, int quantity);
}
