import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../entities/wishlist_product.dart';
import '../repositories/wishlist_repository.dart';

class RemoveFromWishlist {
  final WishlistRepository repository;
  RemoveFromWishlist(this.repository);

  Future<Either<Failure, List<WishlistProduct>>> call(String productId) =>
      repository.removeFromWishlist(productId);
}
