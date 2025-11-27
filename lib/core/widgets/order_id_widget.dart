import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../utils/custom_themes.dart';

class OrderIdWidget extends StatelessWidget {
  const OrderIdWidget({
    super.key,
    required this.orderId,
  });

  final String orderId;

  @override
  Widget build(BuildContext context) => Row(
      children: [
        Text(
          'ID:',
          style: textBold.copyWith(
            color: kMuted,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(width: 4),
        Text(
          '#$orderId',
          style: textBold.copyWith(
            color: kTextDark.withOpacity(0.40),
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
}
