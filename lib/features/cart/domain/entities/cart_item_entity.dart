import 'package:equatable/equatable.dart';

class CartItemEntity extends Equatable {
  const CartItemEntity(
      {required this.id,
      required this.name,
      required this.price,
      this.originalPrice,
      required this.quantity,
      required this.thumbnail,
      this.discountedPrice,
      this.maxQuantity,
      this.discount,
      this.discountType,
      this.tax,
      this.taxModel,
      this.taxType,
      this.increment,
      this.decrement});
  final String id;
  final String name;
  final double price;
  final double? originalPrice;
  final int quantity;
  final String thumbnail;
  final double? discountedPrice;
  final int? maxQuantity;
  final double? discount;
  final String? discountType;
  final double? tax;
  final String? taxModel;
  final String? taxType;
  final bool? increment;
  final bool? decrement;

  num get totalPrice => price * quantity;

  CartItemEntity copyWith(
          {String? id,
          String? name,
          double? price,
          double? originalPrice,
          int? quantity,
          String? thumbnail,
          double? discountedPrice,
          int? maxQuantity,
          double? discount,
          String? discountType,
          double? tax,
          String? taxModel,
          String? taxType,
          bool? increment,
          bool? decrement}) =>
      CartItemEntity(
          id: id ?? this.id,
          name: name ?? this.name,
          price: price ?? this.price,
          originalPrice: originalPrice ?? this.originalPrice,
          quantity: quantity ?? this.quantity,
          thumbnail: thumbnail ?? this.thumbnail,
          discountedPrice: discountedPrice ?? this.discountedPrice,
          maxQuantity: maxQuantity ?? this.maxQuantity,
          discount: discount ?? this.discount,
          discountType: discountType ?? this.discountType,
          tax: tax ?? this.tax,
          taxModel: taxModel ?? this.taxModel,
          taxType: taxType ?? this.taxType,
          increment: increment ?? this.increment,
          decrement: decrement ?? this.decrement);
  @override
  List<Object?> get props => [
        id,
        name,
        price,
        originalPrice,
        quantity,
        thumbnail,
        discountedPrice,
        maxQuantity,
        tax,
        taxModel,
        taxType,
        increment,
        decrement
      ];
}
