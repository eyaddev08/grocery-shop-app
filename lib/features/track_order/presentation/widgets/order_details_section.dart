import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/custom_themes.dart';
import '../../../../features/orders/domain/entities/order.dart';
import '../../../../core/widgets/order_id_widget.dart';
import '../../../../core/widgets/order_status_badge_widget.dart';

class OrderDetailsSection extends StatelessWidget {
  const OrderDetailsSection({
    super.key,
    required this.order,
    required this.orderId,
  });

  final Order? order;
  final String orderId;

  @override
  Widget build(BuildContext context) => Container(
        width: double.infinity,
        decoration: ShapeDecoration(
          color: kSoftBg,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: Theme(
          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
          child: ExpansionTile(
            tilePadding: const EdgeInsets.symmetric(horizontal: 24),
            childrenPadding: const EdgeInsets.symmetric(horizontal: 36),
            collapsedBackgroundColor: Colors.transparent,
            backgroundColor: Colors.transparent,
            title: Row(
              children: [
                Text(
                  'Order Details',
                  style: textBold.copyWith(
                    color: kTextDark,
                  ),
                ),
                const SizedBox(width: 8),
                OrderIdWidget(orderId: orderId),
              ],
            ),
            trailing: const Icon(Icons.keyboard_arrow_down, color: kMutedGray),
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Container(
                  width: 75,
                  height: 4,
                  decoration: ShapeDecoration(
                    color: kMutedGray,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(70),
                    ),
                  ),
                ),
              ),

              // Product Info
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                      child: Column(
                    children: [
                      _buildDetailRow(
                        'Product Name',
                        order!.productName,
                        Icons.shopping_bag_outlined,
                      ),
                      const SizedBox(height: 16),
                      _buildDetailRow('Price', '${order!.price}\$',
                          Icons.attach_money_outlined),
                    ],
                  )),
                ],
              ),

              const SizedBox(height: 16),
              // Order Date
              _buildDetailRow(
                'Order Date',
                order!.date,
                Icons.calendar_month_outlined,
              ),
              const SizedBox(height: 16),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.info_outline_rounded,
                      size: 19, color: kMuted),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Status',
                      style: textBold.copyWith(
                        color: kTextDark,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  if (order!.status == OrderStatus.success)
                    const OrderStatusBadgeWidget(statusText: 'Success')
                  else if (order!.status == OrderStatus.active)
                    const OrderStatusBadgeWidget(
                      statusText: 'Active',
                      textColor: kAccentYellow,
                      backgroundColor: Color(0x19F9B023),
                    )
                  else
                    const OrderStatusBadgeWidget(
                      statusText: 'Cancelled',
                      textColor: Colors.red,
                      backgroundColor: Color(0x19D32F2F),
                    ),
                ],
              ),

              if (order!.deliveryMessage != null) ...[
                const SizedBox(height: 24),
                const Divider(color: kMutedGray, height: 1),
                const SizedBox(height: 24),
                Text(
                  'Delivery Message',
                  style: textBold.copyWith(
                    color: kTextDark,
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  order!.deliveryMessage!,
                  style: textBold.copyWith(
                    color: kMuted,
                    fontSize: 13,
                  ),
                ),
              ],
            ],
          ),
        ),
      );
}

Widget _buildDetailRow(String label, String value, IconData icon) => Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 19, color: kMuted),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            '$label :',
            style: textBold.copyWith(
              color: kTextDark,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Text(
          value,
          style: textBold.copyWith(
            color: kMuted,
            fontSize: 13,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
