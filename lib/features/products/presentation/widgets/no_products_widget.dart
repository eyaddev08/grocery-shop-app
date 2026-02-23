import 'package:flutter/material.dart';
import 'package:grocery_shop_app/core/utils/images.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/styles.dart';
import '../../../../core/widgets/custom_asset_image_widget.dart';
import '../../../../core/widgets/custom_button_widget.dart';

class NoProductsWidget extends StatelessWidget {

  const NoProductsWidget({super.key, required this.message, this.onShowAll});
  final String message;
  final VoidCallback? onShowAll;

  @override
  Widget build(BuildContext context) => Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 28),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CustomAssetImageWidget(Images.noProduct,
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
                buttonText: 'Show all products',
                onTap: onShowAll,
                buttonWidth: 200,
              ),
          ],
        ),
      ),
    );
}