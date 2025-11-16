class Order {
  final String id;
  final String productName;
  final double price;
  final String? imageUrl;
  final String date;
  final OrderStatus status;
  final String? riderName;
  final String? deliveryMessage;

  const Order({
    required this.id,
    required this.productName,
    required this.price,
    this.imageUrl,
    required this.date,
    required this.status,
    this.riderName,
    this.deliveryMessage,
  });
}

enum OrderStatus {
  active,
  success,
  cancelled,
}
