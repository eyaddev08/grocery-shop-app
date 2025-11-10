class WishlistProduct {

  const WishlistProduct({
    required this.id,
    required this.title,
    required this.price,
    this.oldPrice,
    required this.subTitle,
    required this.imageUrl,
    this.discount,
    this.isFavorite = true,
  });
  final String id;
  final String title;
  final double price;
  final double? oldPrice;
  final String subTitle;
  final String imageUrl;
  final int? discount;
  final bool isFavorite;

  WishlistProduct copyWith({
    String? id,
    String? title,
    double? price,
    double? oldPrice,

    String? subTitle,
    String? color,
    String? imageUrl,
    int? discount,
    bool? isFavorite,
  }) => WishlistProduct(
      id: id ?? this.id,
      title: title ?? this.title,
      price: price ?? this.price,
      oldPrice: oldPrice ?? this.oldPrice,
      subTitle: subTitle ?? this.subTitle,
      imageUrl: imageUrl ?? this.imageUrl,
      discount: discount ?? this.discount,
      isFavorite: isFavorite ?? this.isFavorite,
    );
}
