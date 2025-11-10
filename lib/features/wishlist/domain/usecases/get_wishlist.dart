import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../entities/wishlist_product.dart';
import '../repositories/wishlist_repository.dart';

class GetWishlist {
  final WishlistRepository repository;
  GetWishlist(this.repository);

  Future<Either<Failure, List<WishlistProduct>>> call() => repository.getWishlist();
}
