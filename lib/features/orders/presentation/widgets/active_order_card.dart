import 'package:flutter/material.dart';
import 'package:grocery_shop_app/core/constants/app_colors.dart';
import '../../../../core/utils/styles.dart';
import '../../../../core/widgets/custom_image_widget.dart';
import '../../domain/entities/order_entity.dart';
import 'order_delivery_section.dart';
import '../../../../core/widgets/order_id_widget.dart';
import 'order_product_info.dart';

class ActiveOrderCard extends StatelessWidget {
  const ActiveOrderCard({
    super.key,
    required this.order,
    this.onTrackOrder,
    this.onCancelOrder,
  });

  final OrderEntity order;
  final VoidCallback? onTrackOrder;
  final VoidCallback? onCancelOrder;

  @override
  Widget build(BuildContext context) {
    final isSingleProduct = order.items.length == 1;
    final displayTitle = isSingleProduct
        ? order.items.first.name
        : '${order.items.length} Products';

    final displayImage =
        order.items.isNotEmpty ? order.items.first.imageUrl : '';
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomImageWidget(
                  image: displayImage,
                  height: 48,
                  width: 48,
                  fit: BoxFit.contain),
              const SizedBox(width: 18),
              Expanded(
                child: OrderProductInfo(
                  productName: displayTitle,
                  price: order.totalAmount,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  OrderIdWidget(orderId: order.id),
                  TextButton(
                      onPressed: onCancelOrder,
                      child: Text('Cancel Order',
                          style: textBold.copyWith(color: errorColor))),
                ],
              )
            ],
          ),
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
  }
}
