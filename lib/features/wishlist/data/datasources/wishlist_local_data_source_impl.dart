import 'package:hive/hive.dart';
import '../models/wishlist_product_model.dart';


abstract class WishlistLocalDataSource {
  Future<List<WishlistProductModel>> getWishlistProducts();

  Future<List<WishlistProductModel>> addToWishlist(WishlistProductModel product);

  Future<List<WishlistProductModel>> removeFromWishlist(String productId);

  Future<bool> isProductInWishlist(String productId);

  Future<List<WishlistProductModel>> toggleFavorite(String productId);
}


class WishlistLocalDataSourceImpl implements WishlistLocalDataSource {

  WishlistLocalDataSourceImpl(this._box);
  final Box<WishlistProductModel> _box;

  @override
  Future<List<WishlistProductModel>> getWishlistProducts() async {
    try {
      return _box.values.toList();
    } catch (e) {
      return [];
    }
  }

  @override
  Future<List<WishlistProductModel>> addToWishlist(WishlistProductModel product) async {
    try {
      await _box.put(product.id, product);
      return _box.values.toList();
    } catch (e) {
      return _box.values.toList();
    }
  }

  @override
  Future<List<WishlistProductModel>> removeFromWishlist(String productId) async {
    try {
      await _box.delete(productId);
      return _box.values.toList();
    } catch (e) {
      return _box.values.toList();
    }
  }

  @override
  Future<bool> isProductInWishlist(String productId) async => _box.containsKey(productId);

  @override
  Future<List<WishlistProductModel>> toggleFavorite(String productId) async {
    try {
      final product = _box.get(productId);
      
      if (product != null) {
        final updatedProduct = product.copyWith(isFavorite: !product.isFavorite);
        await _box.put(productId, updatedProduct);
      }
      
      return _box.values.toList();
    } catch (e) {
      return _box.values.toList();
    }
  }
}

