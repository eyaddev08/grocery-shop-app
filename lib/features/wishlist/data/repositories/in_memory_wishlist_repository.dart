import 'dart:async';
import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../../domain/entities/wishlist_product.dart';
import '../../domain/repositories/wishlist_repository.dart';
import '../models/product_model.dart';

class InMemoryWishlistRepository implements WishlistRepository {
  InMemoryWishlistRepository({List<ProductModel>? seed})
      : _storage = seed ??
            [
              const ProductModel(
                id: 'p1',
                title: 'Clownfish',
                price: 10,
                oldPrice: 15,
                subTitle: 'Sea fish',
                imageUrl: 'assets/svg/empty_image.svg',
                discount: 20,
              ),
              const ProductModel(
                id: 'p2',
                title: 'Gold Fish',
                price: 6,
                subTitle: 'Fresh',
                imageUrl: 'assets/svg/empty_image.svg',
              ),
              const ProductModel(
                id: 'p3',
                title: 'Tang',
                price: 4,
                subTitle: 'Big tang',
                imageUrl: 'assets/svg/empty_image.svg',
              ),
            ];
  final List<ProductModel> _storage;

  Future<void> _fakeDelay() async =>
      Future.delayed(const Duration(milliseconds: 350));

  @override
  Future<Either<Failure, List<WishlistProduct>>> getWishlist() async {
    try {
      await _fakeDelay();
      return right(List<WishlistProduct>.from(_storage));
    } catch (e) {
      return left(Failure('Failed to load wishlist'));
    }
  }

  @override
  Future<Either<Failure, List<WishlistProduct>>> removeFromWishlist(
      String productId) async {
    try {
      await _fakeDelay();
      _storage.removeWhere((p) => p.id == productId);
      return right(List<WishlistProduct>.from(_storage));
    } catch (e) {
      return left(Failure('Failed to remove item'));
    }
  }

  @override
  Future<Either<Failure, List<WishlistProduct>>> toggleFavorite(
      String productId) async {
    try {
      await _fakeDelay();
      final idx = _storage.indexWhere((p) => p.id == productId);
      if (idx >= 0) {
        final current = _storage[idx];
        _storage[idx] =
            current.copyWith(isFavorite: !current.isFavorite) as ProductModel;
      }
      return right(List<WishlistProduct>.from(_storage));
    } catch (e) {
      return left(Failure('Failed to toggle favorite'));
    }
  }
}
