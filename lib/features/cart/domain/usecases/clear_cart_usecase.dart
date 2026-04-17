import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../../domain/repositories/cart_repository.dart';

class ClearCartUseCase {

  ClearCartUseCase(this.repository);
  final CartRepository repository;

  Future<Either<Failure, Unit>> call() async => await repository.clearCart();
}
