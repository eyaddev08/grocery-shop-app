import 'package:dartz/dartz.dart';
import 'package:grocery_shop_app/core/error/failure.dart';
import '../entities/cart_item_entity.dart';

abstract class CartRepository {
  Future<Either<Failure, List<CartItemEntity>>> getCart();
  Future<Either<Failure, Unit>> addItem(CartItemEntity item);
  Future<Either<Failure, Unit>> removeItem(String id);
  Future<Either<Failure, Unit>> updateQuantity(String id, int quantity);
  Future<Either<Failure, Unit>> clearCart();
}
