import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/cart_item_entity.dart';
import '../../domain/repositories/cart_repository.dart';
import '../datasources/cart_local_data_source.dart';
import '../datasources/cart_remote_data_source.dart';
import '../mappers/cart_item_mapper.dart';

class CartRepositoryImpl implements CartRepository {

  CartRepositoryImpl(
      {required this.remoteDataSource,
      required this.localDataSource,
      required this.networkInfo});
  final CartRemoteDataSource remoteDataSource;
  final CartLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  @override
  Future<Either<Failure, List<CartItemEntity>>> getCart() async {
    try {
      final models = await localDataSource.getCart();
      return Right(models.map((e) => e.toEntity()).toList());
    } catch (e) {
      return Left(CacheFailure( 'Failed to fetch cart items: $e'));
    }
  }

  @override
  Future<Either<Failure, Unit>> addItem(CartItemEntity item) async {
    try {
      final model = CartItemMapper.toModel(item);
      await localDataSource.addItem(model);
      return const Right(unit);
    } catch (e) {
      return Left(CacheFailure( 'Failed to add item to cart'));
    }
  }

  @override
  Future<Either<Failure, Unit>> removeItem(String productId) async {
    try {
      await localDataSource.removeItem(productId);
      return const Right(unit);
    } catch (e) {
      return Left(CacheFailure( 'Failed to remove item'));
    }
  }

  @override
  Future<Either<Failure, Unit>> updateQuantity(
      String productId, int quantity) async {
    try {
      await localDataSource.updateQuantity(productId, quantity);
      return const Right(unit);
    } catch (e) {
      return Left(CacheFailure( 'Failed to update quantity'));
    }
  }

  @override
  Future<Either<Failure, Unit>> clearCart() async {
    try {
      await localDataSource.clearCart();
      return const Right(unit);
    } catch (e) {
      return Left(CacheFailure( 'Failed to clear cart'));
    }
  }
}