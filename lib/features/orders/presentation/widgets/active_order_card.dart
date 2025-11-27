import 'package:flutter/material.dart';
import '../../domain/entities/order.dart';
import 'order_delivery_section.dart';
import '../../../../core/widgets/order_id_widget.dart';
import 'order_product_image.dart';
import 'order_product_info.dart';

class ActiveOrderCard extends StatelessWidget {
  const ActiveOrderCard({
    super.key,
    required this.order,
    this.onTrackOrder,
  });

  final Order order;
  final VoidCallback? onTrackOrder;

  @override
  Widget build(BuildContext context) => Container(
        margin: const EdgeInsets.only(bottom: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProductInfoRow(),
            const SizedBox(height: 20),
            OrderDeliverySection(
              deliveryMessage: order.deliveryMessage,
              riderName: order.riderName,
              onTrackOrder: onTrackOrder,
            ),
            const SizedBox(height: 10),
          ],
        ),
      );

  Widget _buildProductInfoRow() => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          OrderProductImage(imageUrl: order.imageUrl),
          const SizedBox(width: 18),
          Expanded(
            child: OrderProductInfo(
              productName: order.productName,
              price: order.price,
            ),
          ),
          OrderIdWidget(orderId: order.id),
        ],
      );
}
