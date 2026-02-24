// import '../../domain/entities/wishlist_product.dart';

// class WishlistProductModel extends WishlistProduct {
//   const WishlistProductModel({
//     required super.id,
//     required super.title,
//     required super.price,

//     super.oldPrice,
//     required super.subTitle,
//     required super.imageUrl,
//     super.discount,
//     super.isFavorite,
//   });

//   factory WishlistProductModel.fromJson(Map<String, dynamic> j) => WishlistProductModel(
//       id: j['id'] as String,
//       title: j['title'] as String,
//       price: (j['price'] as num).toDouble(),
//       oldPrice: j['oldPrice'] != null ? (j['oldPrice'] as num).toDouble() : null,
//       subTitle: j['subTitle'] as String,
//       imageUrl: j['imageUrl'] as String,
//       discount: j['discount'] as int?,
//       isFavorite: j['isFavorite'] as bool? ?? true,
//     );

//   Map<String, dynamic> toJson() => {
//       'id': id,
//       'title': title,
//       'price': price,
//       'oldPrice': oldPrice,
//       'subTitle': subTitle,
//       'imageUrl': imageUrl,
//       'discount': discount,
//       'isFavorite': isFavorite,
//     };
// }

import '../../domain/entities/wishlist_product.dart';

class WishlistProductModel extends WishlistProduct {
  const WishlistProductModel({
    required super.id,
    required super.title,
    required super.price,
    super.oldPrice,
    required super.subTitle,
    required String? tag,
    required super.thumbnail,
    super.discount,
    super.isFavorite,
    required super.images,
    required super.nutritionLines,
    required super.rating,
    required super.reviewCount,
    required super.currentStock,
    required super.categoryIds,
    required super.minOrderQty,
    required super.status,
  });

  factory WishlistProductModel.fromJson(Map<String, dynamic> j) =>
      WishlistProductModel(
        id: j['id']?.toString() ?? '',
        title: j['title']?.toString() ?? '',
        price: num.tryParse(j['price']?.toString() ?? '0')?.toDouble() ?? 0.0,
        oldPrice: j['oldPrice'] != null
            ? num.tryParse(j['oldPrice'].toString())?.toDouble()
            : null,
        subTitle: j['subTitle']?.toString() ?? '',
        tag: j['tag']?.toString() ?? '',
        thumbnail: j['thumbnail']?.toString() ?? '',
        discount: num.tryParse(j['discount']?.toString() ?? '')?.toDouble(),
        isFavorite: j['isFavorite'] as bool? ?? true,
        images: (j['images'] as List<dynamic>?)
                ?.map((e) => e.toString())
                .toList() ??
            [],
        nutritionLines: (j['nutritionLines'] as List<dynamic>?)
                ?.map((e) => e.toString())
                .toList() ??
            [],
        rating: num.tryParse(j['rating']?.toString() ?? '0')?.toDouble() ?? 0.0,
        reviewCount:
            num.tryParse(j['reviewCount']?.toString() ?? '0')?.toInt() ?? 0,
        currentStock:
            num.tryParse(j['currentStock']?.toString() ?? '0')?.toInt() ?? 0,
        categoryIds: (j['categoryIds'] as List<dynamic>?)
                ?.map((e) => int.parse(e.toString()))
                .toList() ??
            [],
        minOrderQty:
            num.tryParse(j['minOrderQty']?.toString() ?? '1')?.toInt() ?? 1,
        status: num.tryParse(j['status']?.toString() ?? '1')?.toInt() ?? 1,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'price': price,
        'oldPrice': oldPrice,
        'subTitle': subTitle,
        'tag': tag,
        'thumbnail': thumbnail,
        'discount': discount,
        'isFavorite': isFavorite,
        'unit': unit,
        'discount_type': discountType,
        'images': images,
        'nutritionLines': nutritionLines,
        'rating': rating,
        'review_count': reviewCount,
        'wish_list_count': isFavorite ? 1 : 0,
        'current_stock': currentStock,
        'short_description': shortDescription,
        'category_ids': categoryIds,
        'brand': brand,
        'minimum_order_qty': minOrderQty,
        'shipping_cost': shippingCost,
        'status': status,
      };
}
