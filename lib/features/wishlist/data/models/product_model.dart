import '../../domain/entities/wishlist_product.dart';

class ProductModel extends WishlistProduct {
  const ProductModel({
    required super.id,
    required super.title,
    required super.price,

    super.oldPrice,
    required super.subTitle,
    required super.imageUrl,
    super.discount,
    super.isFavorite,
  });

  factory ProductModel.fromJson(Map<String, dynamic> j) => ProductModel(
      id: j['id'] as String,
      title: j['title'] as String,
      price: (j['price'] as num).toDouble(),
      oldPrice: j['oldPrice'] != null ? (j['oldPrice'] as num).toDouble() : null,
      subTitle: j['subTitle'] as String,
      imageUrl: j['imageUrl'] as String,
      discount: j['discount'] as int?,
      isFavorite: j['isFavorite'] as bool? ?? true,
    );

  Map<String, dynamic> toJson() => {
      'id': id,
      'title': title,
      'price': price,
      'oldPrice': oldPrice,
      'subTitle': subTitle,
      'imageUrl': imageUrl,
      'discount': discount,
      'isFavorite': isFavorite,
    };
}
