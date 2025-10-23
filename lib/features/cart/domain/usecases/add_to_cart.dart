import 'package:dartz/dartz.dart';
import 'package:grocery_shop_app/core/error/failure.dart';
import '../repositories/cart_repository.dart';
import '../entities/cart_item.dart';

class AddToCart {
  final CartRepository repository;
  AddToCart(this.repository);

  Future<Either<Failure, List<CartItem>>> call(CartItem item) async {
    return await repository.addItem(item);
  }
}
