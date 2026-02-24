import '../../domain/entities/cart_item.dart';

abstract class CartRemoteDataSource {
  Future<List<CartItem>> getCart();
  Future<List<CartItem>> addItem(CartItem item);
  Future<List<CartItem>> removeItem(String id);
  Future<void> clearCart();

  Future<List<CartItem>> updateQuantity(String id, int quantity);
}

class CartRemoteDataSourceImpl implements CartRemoteDataSource {
  // Simulating a remote interaction. In a real app, this would use Dio to call an API.

  @override
  Future<List<CartItem>> getCart() async {
    await Future<void>.delayed(const Duration(milliseconds: 500));
    return [];
  }

  @override
  Future<List<CartItem>> addItem(CartItem item) async {
    await Future<void>.delayed(const Duration(milliseconds: 500));
    return [];
  }

  @override
  Future<List<CartItem>> removeItem(String id) async {
    await Future<void>.delayed(const Duration(milliseconds: 500));
    return [];
  }

  @override
  Future<List<CartItem>> updateQuantity(String id, int quantity) async {
    await Future<void>.delayed(const Duration(milliseconds: 500));
    return [];
  }

  @override
  Future<void> clearCart() async {
    await Future<void>.delayed(const Duration(milliseconds: 500));
  }
}
