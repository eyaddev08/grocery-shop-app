import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../entities/wishlist_product_entity.dart';

abstract class WishlistRepository {
  Future<Either<Failure, List<WishlistProductEntity>>> getWishlist();
  Future<Either<Failure, List<WishlistProductEntity>>> addToWishlist(
      WishlistProductEntity product);
  Future<Either<Failure, List<WishlistProductEntity>>> removeFromWishlist(
      String productId);
  Future<Either<Failure, List<WishlistProductEntity>>> toggleFavorite(
      String productId);
}
