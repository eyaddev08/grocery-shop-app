class Order {
  final String id;
  final String productName;
  final double price;
  final String? imageUrl;
  final String date;
  final OrderStatus status;
  final String? riderName;
  final String? deliveryMessage;
  final int quantity;

  const Order({
    required this.id,
    required this.productName,
    required this.price,
    this.imageUrl,
    required this.date,
    required this.status,
    this.riderName,
    this.deliveryMessage,
    required this.quantity,
  });
}

enum OrderStatus {
  active,
  success,
  cancelled,
}
