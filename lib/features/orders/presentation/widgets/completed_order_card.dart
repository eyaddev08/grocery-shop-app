import 'package:flutter/material.dart';
import '../../domain/entities/order.dart';
import 'order_id_widget.dart';
import 'order_product_image.dart';
import 'order_product_info.dart';
import 'order_status_badge.dart';

class CompletedOrderCard extends StatelessWidget {
  const CompletedOrderCard({
    super.key,
    required this.order,
  });

  final Order order;

  @override
  Widget build(BuildContext context) => Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          OrderProductImage(imageUrl: order.imageUrl),
          const SizedBox(width: 18),
          Expanded(
            child: OrderProductInfo(
              productName: order.productName,
              price: order.price,
              date: order.date,
              showDate: true,
            ),
          ),
          _buildOrderIdAndStatus(),
        ],
      ),
    );

  Widget _buildOrderIdAndStatus() => Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        OrderIdWidget(orderId: order.id),
        const SizedBox(height: 24),
        const OrderStatusBadge(statusText: 'Success'),
      ],
    );
}
