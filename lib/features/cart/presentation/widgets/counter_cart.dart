import 'package:flutter/material.dart';
import 'package:grocery_shop_app/core/utils/dimensions.dart';

import '../../../../core/constants/app_colors.dart';

class CounterCart extends StatelessWidget {
  const CounterCart({
    super.key,
    required this.onTap,
    required this.icon,
  });

  final VoidCallback onTap;
  final IconData icon;

  @override
  Widget build(BuildContext context) => Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(Dimensions.radiusExtraLarge),
          onTap: onTap,
          child: Container(
            width: 40,
            height: 40,
            decoration: ShapeDecoration(
              color: kTextDark.withOpacity(0.06),
              shape: const OvalBorder(),
            ),
            child: Icon(icon, size: Dimensions.iconSizeSmall, color: kTextDark),
          ),
        ),
      );
}
