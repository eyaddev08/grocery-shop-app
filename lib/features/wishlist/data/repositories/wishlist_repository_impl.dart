import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:grocery_shop_app/features/wishlist/data/mappers/wishlist_product_mapper.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/wishlist_product_entity.dart';
import '../../domain/repositories/wishlist_repository.dart';

import '../datasources/wishlist_local_data_source_impl.dart';
import '../datasources/wishlist_remote_data_source_impl.dart';

class WishlistRepositoryImpl implements WishlistRepository {
  WishlistRepositoryImpl({
    required this.localDataSource,
    required this.remoteDataSource,
    required this.networkInfo,
  });
  final WishlistLocalDataSource localDataSource;
  final WishlistRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  @override
  Future<Either<Failure, List<WishlistProductEntity>>> getWishlist() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteProducts = await remoteDataSource.getWishlist();

        await Future.wait(
          remoteProducts
              .map((product) => localDataSource.addToWishlist(product)),
        );

        return right(remoteProducts);
      } catch (e) {
        return _getLocalWishlist();
      }
    } else {
      return _getLocalWishlist();
    }
  }

  @override
  Future<Either<Failure, List<WishlistProductEntity>>> addToWishlist(
      WishlistProductEntity product) async {
    final productModel = WishlistProductMapper.toModel(product);

    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.addToWishlist(productModel);
      } catch (e) {
        debugPrint('Failed to add to remote wishlist: $e');
      }
    }

    try {
      final localProducts = await localDataSource.addToWishlist(productModel);
      return right(localProducts);
    } catch (e) {
      return left(
          ServerFailure('Failed to add item to wishlist: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, List<WishlistProductEntity>>> removeFromWishlist(
      String productId) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.removeFromWishlist(productId);
      } catch (e) {
        debugPrint('Failed to remove from remote wishlist: $e');
      }
    }

    try {
      final localProducts = await localDataSource.removeFromWishlist(productId);
      return right(localProducts);
    } catch (e) {
      return left(ServerFailure('Failed to remove item: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, List<WishlistProductEntity>>> toggleFavorite(
      String productId) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.toggleFavorite(productId);
      } catch (e) {
        debugPrint('Failed to toggle favorite on remote: $e');
      }
    }

    try {
      final localProducts = await localDataSource.toggleFavorite(productId);
      return right(localProducts);
    } catch (e) {
      return left(ServerFailure('Failed to toggle favorite: ${e.toString()}'));
    }
  }

  // --- دوال مساعدة (Private Helpers) لتقليل التكرار ---

  Future<Either<Failure, List<WishlistProductEntity>>>
      _getLocalWishlist() async {
    try {
      final localProducts = await localDataSource.getWishlistProducts();
      return right(localProducts);
    } catch (e) {
      return left(
          ServerFailure('Failed to load local wishlist: ${e.toString()}'));
    }
  }
}
