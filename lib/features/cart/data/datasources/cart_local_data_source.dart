import 'dart:convert';

import 'package:grocery_shop_app/core/error/exception.dart';
import 'package:hive/hive.dart';

import '../models/cart_item_model.dart';

abstract class CartLocalDataSource {
  Future<List<CartItemModel>> getCart();
  Future<void> cacheCart(List<CartItemModel> items);
  Future<void> addItem(CartItemModel item);
  Future<void> removeItem(String id);
  Future<void> updateQuantity(String id, int quantity);
  Future<void> clearCart();
}

class CartLocalDataSourceImpl implements CartLocalDataSource {
  CartLocalDataSourceImpl({required this.box});
  final Box<String> box;
  static const String _kCartKey = 'cached_cart';

  @override
  Future<void> addItem(CartItemModel item) async {
    final List<CartItemModel> currentCart = await getCart();
    final index = currentCart.indexWhere((element) => element.id == item.id);
    if (index >= 0) {
      final existing = currentCart[index];
      currentCart[index] = CartItemModel(
        id: existing.id,
        name: existing.name,
        price: existing.price,
        thumbnail: existing.thumbnail,
        quantity: existing.quantity + item.quantity,
        originalPrice: existing.originalPrice,
        discount: existing.discount
      );
    } else {
      currentCart.add(item);
    }
    await cacheCart(currentCart);
  }

  @override
  Future<void> cacheCart(List<CartItemModel> items) async {
    final List<Map<String, dynamic>> jsonList =
        items.map((e) => e.toJson()).toList();
    await box.put(_kCartKey, jsonEncode(jsonList));
  }

  @override
  Future<List<CartItemModel>> getCart() async {
    final jsonString = box.get(_kCartKey);
    if (jsonString != null) {
      final List<dynamic> jsonList = jsonDecode(jsonString) as List<dynamic>;
      return jsonList
          .map((e) => CartItemModel.fromJson(e as Map<String, dynamic>))
          .toList();
    }
    return [];
  }

  @override
  Future<void> removeItem(String id) async {
    final List<CartItemModel> currentCart = await getCart();
    currentCart.removeWhere((element) => element.id == id);
    await cacheCart(currentCart);
  }

  @override
  Future<void> updateQuantity(String id, int quantity) async {
    final List<CartItemModel> currentCart = await getCart();
    final index = currentCart.indexWhere((element) => element.id == id);
    if (index >= 0) {
      final existing = currentCart[index];
      currentCart[index] = CartItemModel(
        id: existing.id,
        name: existing.name,
        price: existing.price,
        thumbnail: existing.thumbnail,
        quantity: quantity,
        originalPrice: existing.originalPrice,
        discount: existing.discount
      );
      await cacheCart(currentCart);
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> clearCart() async {
    await box.delete(_kCartKey);
  }
}
