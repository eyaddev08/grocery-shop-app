import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/styles.dart';
import '../../../../core/utils/images.dart';
import '../../../../core/widgets/custom_asset_image_widget.dart';
import '../../../../core/widgets/order_rider_avatar_widget.dart';

class DeliveryManCard extends StatelessWidget {
  const DeliveryManCard({
    super.key,
    required this.deliveryManName,
    this.onChatTap,
  });

  final String deliveryManName;
  final VoidCallback? onChatTap;

  @override
  Widget build(BuildContext context) => Container(
        width: 335,
        height: 81,
        margin: const EdgeInsets.symmetric(horizontal: 20),
        decoration: ShapeDecoration(
          color: kSoftBg,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16.5),
          child: Row(
            children: [
              const OrderRiderAvatar(size: 48, iconSize: 24),
              const SizedBox(width: 13),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Delivery Man',
                      style: textBold.copyWith(
                        color: kMuted,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      deliveryManName,
                      style: textBold.copyWith(
                        color: kTextDark,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: onChatTap,
                child: Container(
                  width: 51,
                  height: 51,
                  padding: const EdgeInsets.all(10),
                  decoration: const ShapeDecoration(
                    color: kPrimaryBlue,
                    shape: OvalBorder(),
                  ),
                  child: const CustomAssetImageWidget(
                    Images.chatIcon,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}
