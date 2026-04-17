import 'package:flutter/material.dart';
import 'package:grocery_shop_app/core/utils/images.dart';
import '../constants/app_colors.dart';
import '../utils/styles.dart';
import 'custom_asset_image_widget.dart';
import 'custom_button_widget.dart';

class NoItemsWidget extends StatelessWidget {
  const NoItemsWidget({super.key, required this.message, this.onShowAll, this.buttonTitle, this.subMessage, this.image});
  final String message;
  final String? buttonTitle;
  final VoidCallback? onShowAll;
  final String? subMessage;
  final String? image;
 
  @override
  Widget build(BuildContext context) => Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomAssetImageWidget(image ?? Images.noProduct,
                  width: 100, height: 100, color: kAccentYellow),
              const SizedBox(height: 18),
              Text(
                message,
                textAlign: TextAlign.center,
                style: textBold.copyWith(fontSize: 16, color: Colors.grey[700]),
              ),
              const SizedBox(height: 8),
              Text(
                'Try another category or check back later.',
                textAlign: TextAlign.center,
                style: textBold.copyWith(fontSize: 13, color: Colors.grey[500]),
              ),
              const SizedBox(height: 18),
              if (onShowAll != null)
                CustomButton(
                  buttonText: buttonTitle ?? 'Show all products',
                  onPressed: onShowAll,
                  buttonWidth: 200,
                ),
            ],
          ),
        ),
      );
}
