class OrderItemEntity {
  const OrderItemEntity({
    required this.productId,
    required this.name,
    required this.price,
    required this.quantity,
    required this.imageUrl,
  });
  final String productId;
  final String name;
  final double price;
  final int quantity;
  final String imageUrl;
}
