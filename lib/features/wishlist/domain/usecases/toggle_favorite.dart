import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../entities/wishlist_product.dart';
import '../repositories/wishlist_repository.dart';

class ToggleFavorite {
  ToggleFavorite(this.repository);
  final WishlistRepository repository;

  Future<Either<Failure, List<WishlistProduct>>> call(String productId) =>
      repository.toggleFavorite(productId);
}
