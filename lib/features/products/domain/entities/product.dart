class Product {

  const Product(
      {required this.id,
      required this.title,
      required this.subtitle,
      required this.filterLabel,
      required this.price,
       this.regularPrice,
      this.image});
  final String id;
  final String title;
  final String subtitle;
   final String? filterLabel;
  final double price;
  final double? regularPrice;
  final String? image;
}
