import '../../../products/domain/entities/product_entity.dart';
import '../entities/wishlist_product_entity.dart';

class WishlistProductEntityMapper  {
 static ProductEntity toProductEntity(WishlistProductEntity product) => ProductEntity(
        id: product.id,
        name: product.name,
        price: product.price,
        originalPrice: product.originalPrice,
        thumbnail: product.thumbnail,
        discount:
            (product.discount != null && product.discountType == 'percent') ? product.discount! : null,
        inWishlist: product.isFavorite,
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
        slug: product.slug ?? '',
        status: product.status,
      );
}