import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:grocery_shop_app/core/utils/images.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/custom_themes.dart';

class DeliveryInfoSection extends StatelessWidget {
  const DeliveryInfoSection({
    super.key,
    required this.deliveryTime,
    required this.deliveryAddress,
    this.distance,
  });

  final String deliveryTime;
  final String deliveryAddress;
  final double? distance;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: _DeliveryInfoItem(
                icon: Images.timeIcon,
                label: 'Delivery In',
                value: deliveryTime,
              ),
            ),
            const SizedBox(height: 20),
            _DeliveryInfoItem(
              icon: Images.locationIcon,
              label: 'Delivery Address',
              value: deliveryAddress,
            ),
          ],
        ),
      );
}

class _DeliveryInfoItem extends StatelessWidget {
  const _DeliveryInfoItem({
    required this.icon,
    required this.label,
    required this.value,
  });

  final String icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SvgPicture.asset(
            icon,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: textBold.copyWith(
                    color: kMuted,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: textBold.copyWith(
                    color: kTextDark,
                  ),
                ),
              ],
            ),
          ),
        ],
      );
}
