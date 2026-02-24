import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../entities/wishlist_product.dart';
import '../repositories/wishlist_repository.dart';

class AddToWishlist {
  final WishlistRepository repository;
  AddToWishlist(this.repository);

  Future<Either<Failure, List<WishlistProduct>>> call(
      WishlistProduct product) =>
      repository.addToWishlist(product);
}

