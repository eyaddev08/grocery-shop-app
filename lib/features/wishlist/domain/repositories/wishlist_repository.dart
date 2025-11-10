import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../entities/wishlist_product.dart';

abstract class WishlistRepository {
  Future<Either<Failure, List<WishlistProduct>>> getWishlist();
  Future<Either<Failure, List<WishlistProduct>>> removeFromWishlist(String productId);
  Future<Either<Failure, List<WishlistProduct>>> toggleFavorite(String productId);
}
