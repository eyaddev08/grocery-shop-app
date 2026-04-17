import '../../../products/domain/entities/product_entity.dart';
import '../../../wishlist/domain/entities/wishlist_product_entity.dart';


class ProductEntityMapper  {
 static WishlistProductEntity toWishlistProduct(ProductEntity product) => WishlistProductEntity(
        id: product.id,
        name: product.name,
        price: product.price,
        originalPrice: product.originalPrice,
        subName: product.shortDescription ?? product.name,
        thumbnail: product.thumbnail ?? '',
        discount:
            (product.discount != null && product.discountType == 'percent') ? product.discount! : null,
        isFavorite: product.inWishlist,
        images: product.images,
        unit: product.unit,
        rating: product.rating,
        minOrderQty: product.minOrderQty,
        discountType: product.discountType,
        nutritionLines: product.nutritionLines,
        categoryIds: product.categoryIds,
        reviewCount: product.reviewCount,
        brand: product.brand,
        shippingCost: product.shippingCost,
        currentStock: product.currentStock,
        tag: product.tag,
        slug: product.slug,
        status: product.status,
      );
}





// extension WishlistProductMapper on ProductEntity {
//   WishlistProductEntity toProductEntity() => WishlistProductEntity(
//       id: id,
//       name: name,
//       price: price,
//       originalPrice: originalPrice,
//       subName: shortDescription ?? name,
//       thumbnail: thumbnail ?? '',
//       discount: (discount != null && discountType == 'percent') ? discount! : null,
//       isFavorite: inWishlist,
//       images: images,
//       unit: unit,
//       rating: rating,
//       minOrderQty: minOrderQty,
//       discountType: discountType,
//       nutritionLines: nutritionLines,
//       categoryIds: categoryIds,
//       reviewCount: reviewCount,
//       brand: brand,
//       shippingCost: shippingCost,
//       currentStock: currentStock,
//       tag: tag,
//       slug: slug,
//       status: status,
//     );
// }