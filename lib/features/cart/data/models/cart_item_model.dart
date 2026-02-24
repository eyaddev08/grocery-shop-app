import '../../domain/entities/cart_item.dart';

class CartItemModel extends CartItem {
  const CartItemModel({
    required super.id,
    required super.title,
    required super.price,
    required super.image,
    required super.quantity,
    required super.regularPrice,
  });

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      id: json['id'] as String,
      title: json['title'] as String,
      price: (json['price'] as num).toDouble(),
      image: json['image'] as String?,
      quantity: json['quantity'] as int,
      regularPrice: (json['regularPrice'] as num?)?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'price': price,
      'image': image,
      'quantity': quantity,
      'regularPrice': regularPrice,
    };
  }

  factory CartItemModel.fromEntity(CartItem item) {
    return CartItemModel(
      id: item.id,
      title: item.title,
      price: item.price,
      image: item.image,
      quantity: item.quantity,
      regularPrice: item.regularPrice,
    );
  }
}
