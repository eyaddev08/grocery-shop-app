import 'package:flutter/material.dart';

import '../../../../core/utils/dimensions.dart';

class CustomContainerWidget extends StatelessWidget {
  const CustomContainerWidget({
    super.key,
    this.child,
    this.padding = const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
    this.margin,
    this.borderRadius = 12,
    this.border,
  });
  final Widget? child;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry? margin;
  final double borderRadius;
  final Border? border;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
      margin: margin,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.fontSizeExtraSmall),
          boxShadow: [
            BoxShadow(
                color: Theme.of(context).hintColor.withOpacity(.05),
                blurRadius: 1,
                spreadRadius: 1,
                offset: const Offset(0, 1))
          ],
          color:
              isDark ? const Color(0xFFF7F8FA) : Theme.of(context).cardColor),
      child: child,
    );
  }
}
