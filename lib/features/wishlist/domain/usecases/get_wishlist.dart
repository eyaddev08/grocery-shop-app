import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../entities/wishlist_product_entity.dart';
import '../repositories/wishlist_repository.dart';

class GetWishlistUseCase {
  GetWishlistUseCase(this.repository);
  final WishlistRepository repository;

  Future<Either<Failure, List<WishlistProductEntity>>> call() =>
      repository.getWishlist();
}
