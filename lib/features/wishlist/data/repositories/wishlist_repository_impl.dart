import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import '../../../../core/error/failure.dart';
import '../../domain/entities/wishlist_product.dart';
import '../../domain/repositories/wishlist_repository.dart';
import '../datasources/wishlist_local_data_source.dart';
import '../datasources/wishlist_remote_data_source.dart';
import '../models/wishlist_product_model.dart';

class WishlistRepositoryImpl implements WishlistRepository {
  final WishlistLocalDataSource localDataSource;
  final WishlistRemoteDataSource? remoteDataSource;

  WishlistRepositoryImpl({
    required this.localDataSource,
    this.remoteDataSource,
  });

  @override
  Future<Either<Failure, List<WishlistProduct>>> getWishlist() async {
    // محاولة جلب البيانات من الخادم أولاً
    if (remoteDataSource != null) {
      try {
        final remoteProducts = await remoteDataSource!.getWishlist();

        // حفظ البيانات في التخزين المحلي
        try {
          for (final product in remoteProducts) {
            await localDataSource.addToWishlist(product);
          }
        } catch (e) {
          debugPrint('Failed to cache remote wishlist: $e');
        }

        return right(List<WishlistProduct>.from(remoteProducts));
      } catch (e) {
        debugPrint('Remote wishlist failed, falling back to local: $e');
        // Fallback to local
      }
    }

    // استخدام البيانات المحلية
    try {
      final products = await localDataSource.getWishlistProducts();
      return right(List<WishlistProduct>.from(products));
    } catch (e) {
      return left(Failure('Failed to load wishlist: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, List<WishlistProduct>>> addToWishlist(
      WishlistProduct product) async {
    final productModel = WishlistProductModel(
      id: product.id,
      title: product.title,
      price: product.price,
      oldPrice: product.oldPrice,
      subTitle: product.subTitle,
      thumbnail: product.thumbnail,
      discount: product.discount,
      isFavorite: product.isFavorite,
      tag: product.tag,
      images: product.images,
      nutritionLines: product.nutritionLines,
      rating: product.rating,
      reviewCount: product.reviewCount,
      currentStock: product.currentStock,
      categoryIds: product.categoryIds,
      minOrderQty: product.minOrderQty,
      status: product.status,
    );

    // محاولة الإضافة على الخادم أولاً
    if (remoteDataSource != null) {
      try {
        await remoteDataSource!.addToWishlist(productModel);
      } catch (e) {
        debugPrint('Failed to add to remote wishlist: $e');
        // نستمر في الإضافة محلياً حتى لو فشل الخادم
      }
    }

    // إضافة محلياً (أو كـ fallback)
    try {
      final products = await localDataSource.addToWishlist(productModel);
      return right(List<WishlistProduct>.from(products));
    } catch (e) {
      return left(Failure('Failed to add item to wishlist: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, List<WishlistProduct>>> removeFromWishlist(
      String productId) async {
    // محاولة الحذف من الخادم أولاً
    if (remoteDataSource != null) {
      try {
        await remoteDataSource!.removeFromWishlist(productId);
      } catch (e) {
        debugPrint('Failed to remove from remote wishlist: $e');
        // نستمر في الحذف محلياً حتى لو فشل الخادم
      }
    }

    // حذف محلياً (أو كـ fallback)
    try {
      final products = await localDataSource.removeFromWishlist(productId);
      return right(List<WishlistProduct>.from(products));
    } catch (e) {
      return left(Failure('Failed to remove item: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, List<WishlistProduct>>> toggleFavorite(
      String productId) async {
    // محاولة التبديل على الخادم أولاً
    if (remoteDataSource != null) {
      try {
        await remoteDataSource!.toggleFavorite(productId);
      } catch (e) {
        debugPrint('Failed to toggle favorite on remote: $e');
        // نستمر في التبديل محلياً حتى لو فشل الخادم
      }
    }

    // تبديل محلياً (أو كـ fallback)
    try {
      final products = await localDataSource.toggleFavorite(productId);
      return right(List<WishlistProduct>.from(products));
    } catch (e) {
      return left(Failure('Failed to toggle favorite: ${e.toString()}'));
    }
  }
}
