import 'package:hive/hive.dart';
import '../models/wishlist_product_model.dart';
import 'wishlist_local_data_source.dart';

class WishlistLocalDataSourceImpl implements WishlistLocalDataSource {
  final Box<dynamic> _box;

  static const String _wishlistKey = 'wishlist_products';

  WishlistLocalDataSourceImpl(this._box);

  @override
  Future<List<WishlistProductModel>> getWishlistProducts() async {
    try {
      final raw = _box.get(_wishlistKey);
      if (raw is List) {
        final List<WishlistProductModel> products = [];
        for (var item in raw) {
          try {
            if (item is Map) {
              final product = WishlistProductModel.fromJson(
                Map<String, dynamic>.from(item),
              );
              products.add(product);
            }
          } catch (e) {
            // تجاهل العناصر التالفة فقط، وليس القائمة بأكملها
            // debugPrint('Error parsing wishlist item: $e');
          }
        }
        return products;
      }
    } catch (e) {
      // في حالة الخطأ العام في القراءة
      return <WishlistProductModel>[];
    }
    return <WishlistProductModel>[];
  }

  @override
  Future<List<WishlistProductModel>> addToWishlist(
      WishlistProductModel product) async {
    try {
      final currentList = await getWishlistProducts();

      // التحقق من عدم وجود المنتج مسبقاً
      if (currentList.any((p) => p.id == product.id)) {
        return currentList;
      }

      // إضافة المنتج الجديد
      final updatedList = [...currentList, product];
      await _box.put(_wishlistKey, updatedList.map((p) => p.toJson()).toList());

      return updatedList;
    } catch (e) {
      // في حالة الخطأ، نعيد القائمة الحالية
      return await getWishlistProducts();
    }
  }

  @override
  Future<List<WishlistProductModel>> removeFromWishlist(
      String productId) async {
    try {
      final currentList = await getWishlistProducts();
      final updatedList = currentList.where((p) => p.id != productId).toList();

      await _box.put(_wishlistKey, updatedList.map((p) => p.toJson()).toList());

      return updatedList;
    } catch (e) {
      return await getWishlistProducts();
    }
  }

  @override
  Future<bool> isProductInWishlist(String productId) async {
    try {
      final products = await getWishlistProducts();
      return products.any((p) => p.id == productId);
    } catch (e) {
      return false;
    }
  }

  @override
  Future<List<WishlistProductModel>> toggleFavorite(String productId) async {
    try {
      final currentList = await getWishlistProducts();
      final index = currentList.indexWhere((p) => p.id == productId);

      if (index >= 0) {
        final product = currentList[index];
        final updatedProduct = product.copyWith(
          isFavorite: !product.isFavorite,
        ) as WishlistProductModel;

        final updatedList = List<WishlistProductModel>.from(currentList);
        updatedList[index] = updatedProduct;

        await _box.put(
            _wishlistKey, updatedList.map((p) => p.toJson()).toList());

        return updatedList;
      }

      return currentList;
    } catch (e) {
      return await getWishlistProducts();
    }
  }
}
