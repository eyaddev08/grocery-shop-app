class ProductDetails {
  final String id;
  final String title;
  final String description;
  final double price;
  final double regularPrice;
  final List<String>? image;
  final List<String> nutritionLines;
  final int reviewCount;

  const ProductDetails(
      {required this.id,
      required this.title,
      required this.description,
      required this.price,
      required this.regularPrice,
      this.image = const [],
      this.nutritionLines = const [],
      this.reviewCount = 0});
}
