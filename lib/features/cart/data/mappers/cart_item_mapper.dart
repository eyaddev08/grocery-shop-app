import '../../domain/entities/cart_item_entity.dart';
import '../models/cart_item_model.dart';

class CartItemMapper {
  static CartItemModel fromJson(Map<String, dynamic> json) => CartItemModel(
        id: json['id']?.toString() ?? '',
        name: json['name']?.toString() ?? '',
        price: (json['price'] as num).toDouble(),
        thumbnail: json['thumbnail']?.toString() ?? '',
        quantity: json['quantity'] as int,
        originalPrice: json['originalPrice'] != null
            ? _parseDouble(json['oldPrice'], 0)
            : null,
        discount: (json['discount'] as num?)?.toDouble() ?? 0,
        discountType: (json['discountType'] as String?)?.toString() ?? '',
        discountedPrice: (json['discountedPrice'] as num?)?.toDouble() ?? 0,
        maxQuantity: (json['maxQuantity'] as int?) ?? 1,
        tax: (json['tax'] as num?)?.toDouble() ?? 0,
        increment: (json['increment'] as bool?) ?? false,
        decrement: (json['decrement'] as bool?) ?? false,
      );

  static CartItemModel toModel(CartItemEntity item) => CartItemModel(
      id: item.id,
      name: item.name,
      price: item.price,
      thumbnail: item.thumbnail,
      quantity: item.quantity,
      originalPrice: item.originalPrice,
      discount: item.discount,
      discountType: item.discountType,
      discountedPrice: item.discountedPrice,
      maxQuantity: item.maxQuantity,
      tax: item.tax,
      increment: item.increment,
      decrement: item.decrement);

  static CartItemEntity toEntity(CartItemModel model) => CartItemEntity(
      id: model.id,
      name: model.name,
      price: model.price,
      thumbnail: model.thumbnail,
      originalPrice: model.originalPrice,
      discount: model.discount,
      discountType: model.discountType,
      quantity: model.quantity,
      discountedPrice: model.discountedPrice,
      maxQuantity: model.maxQuantity,
      tax: model.tax,
      increment: model.increment,
      decrement: model.decrement);

  static Map<String, dynamic> toJson(CartItemModel model) => {
        'id': model.id,
        'name': model.name,
        'price': model.price,
        'thumbnail': model.thumbnail,
        'quantity': model.quantity,
        'regularPrice': model.originalPrice,
        'discount': model.discount,
        'discountType': model.discountType,
        'discountedPrice': model.discountedPrice,
        'maxQuantity': model.maxQuantity,
        'tax': model.tax,
        'increment': model.increment,
        'decrement': model.decrement
      };
  static double _parseDouble(dynamic value, [double fallback = 0.0]) {
    if (value == null) return fallback;
    return double.tryParse(value.toString()) ?? fallback;
  }
}
