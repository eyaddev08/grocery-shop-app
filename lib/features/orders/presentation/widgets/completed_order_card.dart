import 'package:flutter/material.dart';
import '../../domain/entities/order_entity.dart';
import '../../../../core/widgets/order_id_widget.dart';
import 'order_product_image.dart';
import 'order_product_info.dart';
import '../../../../core/widgets/order_status_badge_widget.dart';

class CompletedOrderCard extends StatelessWidget {
  const CompletedOrderCard({
    super.key,
    required this.order,
  });

  final OrderEntity order;

  @override
  Widget build(BuildContext context) {
    final isSingleProduct = order.items.length == 1;
    final displayTitle = isSingleProduct 
        ? order.items.first.name 
        : '${order.items.length} Products'; 
        
    final displayImage = order.items.isNotEmpty 
        ? order.items.first.imageUrl 
        : ''; 

    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          OrderProductImage(imageUrl: displayImage),
          const SizedBox(width: 18),
          Expanded(
            child: OrderProductInfo(
              productName: displayTitle,
              price: order.totalAmount, 
              date: order.createdAt.toString(),
              showDate: true,
            ),
          ),
        Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        OrderIdWidget(orderId: order.id),
        const SizedBox(height: 24),
        OrderStatusBadgeWidget(statusText: order.status.name), 
      ],
    )
        ],
      ),
    );
  }
}