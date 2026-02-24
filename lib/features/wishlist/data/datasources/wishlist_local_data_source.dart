import '../models/wishlist_product_model.dart';

abstract class WishlistLocalDataSource {
  /// يحصل على جميع المنتجات في قائمة الأمنيات
  Future<List<WishlistProductModel>> getWishlistProducts();

  /// يضيف منتج إلى قائمة الأمنيات
  Future<List<WishlistProductModel>> addToWishlist(WishlistProductModel product);

  /// يزيل منتج من قائمة الأمنيات
  Future<List<WishlistProductModel>> removeFromWishlist(String productId);

  /// يتحقق من وجود منتج في قائمة الأمنيات
  Future<bool> isProductInWishlist(String productId);

  /// يبدل حالة المفضلة للمنتج
  Future<List<WishlistProductModel>> toggleFavorite(String productId);
}

