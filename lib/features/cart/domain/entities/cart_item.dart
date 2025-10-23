class CartItem {
  final String id;
  final String title;
  final double price;
  final double? regularPrice;
  final int quantity;
  final String? image;

  const CartItem(
      {required this.id,
      required this.title,
      required this.price,
       this.regularPrice,
      required this.quantity,
      this.image});
}
