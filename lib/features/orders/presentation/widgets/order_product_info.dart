import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/styles.dart';

class OrderProductInfo extends StatelessWidget {
  const OrderProductInfo({
    super.key,
    required this.productName,
    required this.price,
    this.date,
    this.showDate = false,
  });

  final String productName;
  final double price;
  final String? date;
  final bool showDate;

  @override
  Widget build(BuildContext context) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          productName,
          style: textBold.copyWith(
            color: kMuted,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          '\$${price.toStringAsFixed(2)}',
          style: textBold.copyWith(
            color: kTextDark,
            fontWeight: FontWeight.w600,
          ),
        ),
        if (showDate && date != null) ...[
          const SizedBox(height: 4),
          Text(
            date!,
            style: textBold.copyWith(color: kMuted),
          ),
        ],
      ],
    );
}
