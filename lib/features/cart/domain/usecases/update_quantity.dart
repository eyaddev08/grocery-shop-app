import 'package:dartz/dartz.dart';
import 'package:grocery_shop_app/core/error/failure.dart';
import '../repositories/cart_repository.dart';

class UpdateQuantityUseCase {
  UpdateQuantityUseCase(this.repository);
  final CartRepository repository;

  Future<Either<Failure, Unit>> call(
      String id, int quantity) async => await repository.updateQuantity(id, quantity);
}