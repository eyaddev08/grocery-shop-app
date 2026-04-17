import '../../domain/entities/cart_item_entity.dart';
import '../mappers/cart_item_mapper.dart';

class CartItemModel extends CartItemEntity{
  const CartItemModel(
      {required this.id,
      required this.name,
      required this.price,
      required this.thumbnail,
      required this.quantity,
       this.originalPrice,
      this.discountedPrice,
      this.maxQuantity,
      this.discount,
      this.discountType,
      this.tax,
      this.taxModel,
      this.taxType,
      this.increment,
      this.decrement}) : super(
        id: id,
        name: name,
        price: price,
        originalPrice: originalPrice,
        quantity: quantity,
        thumbnail: thumbnail,
        discountedPrice: discountedPrice,
        maxQuantity: maxQuantity,
        discount: discount,
        discountType: discountType,
        tax: tax,
        taxModel: taxModel,
        taxType: taxType,
        increment: increment,
        decrement: decrement);
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


  factory CartItemModel.fromJson(Map<String, dynamic> json) => 
      CartItemMapper.fromJson(json);

  Map<String, dynamic> toJson() => CartItemMapper.toJson(this);

  CartItemEntity toEntity() => CartItemMapper.toEntity(this);

  CartItemModel toModel() => CartItemMapper.toModel(this);
  
}
