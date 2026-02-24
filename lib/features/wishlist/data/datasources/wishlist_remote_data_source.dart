
import '../models/wishlist_product_model.dart';

abstract class WishlistRemoteDataSource {
  /// يحصل على جميع المنتجات في قائمة الأمنيات من الخادم
  Future<List<WishlistProductModel>> getWishlist();

  /// يضيف منتج إلى قائمة الأمنيات على الخادم
  Future<WishlistProductModel> addToWishlist(WishlistProductModel product);

  /// يزيل منتج من قائمة الأمنيات على الخادم
  Future<void> removeFromWishlist(String productId);

  /// يبدل حالة المفضلة للمنتج على الخادم
  Future<WishlistProductModel> toggleFavorite(String productId);
}
