import 'package:dartz/dartz.dart';
import 'package:grocery_shop_app/core/error/failure.dart';
import '../repositories/cart_repository.dart';
import '../entities/cart_item.dart';

class GetCartUseCase {
  final CartRepository repository;

  GetCartUseCase(this.repository);

  Future<Either<Failure, List<CartItem>>> call() async {
    return await repository.getCart();
  }
}
