import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/custom_themes.dart';

class OrderStatusBadge extends StatelessWidget {
  const OrderStatusBadge({
    super.key,
    required this.statusText,
    this.backgroundColor,
    this.textColor,
  });

  final String statusText;
  final Color? backgroundColor;
  final Color? textColor;

  @override
  Widget build(BuildContext context) => Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 4,
      ),
      decoration: ShapeDecoration(
        color: backgroundColor ?? const Color(0x192A4BA0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
      ),
      child: Text(
        statusText,
        textAlign: TextAlign.center,
        style: textBold.copyWith(
          fontSize: 12,
          color: textColor ?? kPrimaryBlue,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
}
