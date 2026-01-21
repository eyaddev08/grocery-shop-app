class ProductEntity {
  const ProductEntity({
    required this.id,
    required this.name,
    this.filterLabel,
    this.tag,
    this.unit,
    required this.price,
    this.originalPrice,
    this.discount,
    this.discountType,
    this.thumbnail,
    this.images = const [],
    this.nutritionLines = const [],
    this.rating = 0.0,
    this.reviewCount = 0,
    this.inWishlist = false,
    this.currentStock = 0,
    this.shortDescription,
    this.categoryIds = const [],
    this.brand,
    this.minOrderQty = 1,
    this.shippingCost,
    this.status = 1,
  });
  final String id;
  final String name;
  final String? filterLabel;
  final String? tag;
  final String? unit;
  final double price; // current/unit price shown in UI
  final double? originalPrice; // optional old price to show discount badge
  final double? discount; // numeric discount (absolute or percent depending)
  final String? discountType; // 'amount' or 'percent' (optional)
  final String? thumbnail; // url
  final List<String> images; // urls
  final List<String> nutritionLines;
  final double rating; // average rating 0.0 - 5.0
  final int reviewCount;
  final bool inWishlist;
  final int currentStock;
  final String? shortDescription;
  final List<int> categoryIds;
  final String? brand;
  final int minOrderQty;
  final double? shippingCost;
  final int status;
}
