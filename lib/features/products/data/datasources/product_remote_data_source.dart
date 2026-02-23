import '../../../../core/data/sample_products.dart';
import '../models/product_model.dart';

abstract class ProductRemoteDataSource {
  Future<List<ProductModel>> getProducts();
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  @override
  Future<List<ProductModel>> getProducts() async {
    // Simulate network delay
    await Future<void>.delayed(const Duration(milliseconds: 900));

    // Map entities to models
    // Since ProductModel doesn't have a fromEntity, we map manually here similar to how it was done in repo
    return productsList
        .map((e) => ProductModel(
              id: e.id,
              name: e.name,
              price: e.price,
              filterLabel: e.filterLabel,
              tag: e.tag,
              unit: e.unit,
              originalPrice: e.originalPrice,
              discount: e.discount,
              discountType: e.discountType,
              thumbnail: e.thumbnail,
              images: e.images,
              nutritionLines: e.nutritionLines,
              rating: e.rating,
              reviewCount: e.reviewCount,
              inWishlist: e.inWishlist,
              currentStock: e.currentStock,
              shortDescription: e.shortDescription,
              categoryIds: e.categoryIds,
              brand: e.brand,
              minOrderQty: e.minOrderQty,
              shippingCost: e.shippingCost,
              status: e.status,
            ))
        .toList();
  }
}
