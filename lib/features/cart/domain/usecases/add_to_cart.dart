import 'package:dartz/dartz.dart';
import 'package:grocery_shop_app/core/error/failure.dart';
import '../repositories/cart_repository.dart';
import '../entities/cart_item_entity.dart';

class AddToCartUseCase {
  AddToCartUseCase(this.repository);
  final CartRepository repository;

  Future<Either<Failure, Unit>> call(
      CartItemEntity item) async => await repository.addItem(item);
}