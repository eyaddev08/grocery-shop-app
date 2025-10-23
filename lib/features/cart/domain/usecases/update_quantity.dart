import 'package:dartz/dartz.dart';
import 'package:grocery_shop_app/core/error/failure.dart';
import '../repositories/cart_repository.dart';
import '../entities/cart_item.dart';

class UpdateQuantity {
  final CartRepository repository;
  UpdateQuantity(this.repository);

  Future<Either<Failure, List<CartItem>>> call(String id, int quantity) async {
    return await repository.updateQuantity(id, quantity);
  }
}
