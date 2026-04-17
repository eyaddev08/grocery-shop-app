import 'package:dartz/dartz.dart';
import 'package:grocery_shop_app/core/error/failure.dart';
import '../repositories/cart_repository.dart';

class RemoveFromCartUseCase {
  RemoveFromCartUseCase(this.repository);
  final CartRepository repository;

  Future<Either<Failure, Unit>> call(String id) async => await repository.removeItem(id);
}
