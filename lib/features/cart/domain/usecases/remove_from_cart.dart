import 'package:dartz/dartz.dart';
import 'package:grocery_shop_app/core/error/failure.dart';
import '../repositories/cart_repository.dart';
import '../entities/cart_item.dart';

class RemoveFromCart {
  final CartRepository repository;
  RemoveFromCart(this.repository);

  Future<Either<Failure, List<CartItem>>> call(String id) async {
    return await repository.removeItem(id);
  }
}
