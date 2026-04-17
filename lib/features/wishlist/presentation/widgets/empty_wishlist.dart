import 'package:flutter/material.dart';
import 'package:grocery_shop_app/core/constants/app_colors.dart';
import 'package:grocery_shop_app/core/utils/styles.dart';
import 'package:grocery_shop_app/core/utils/images.dart';

import '../../../../core/widgets/custom_button_widget.dart';

class EmptyWishlist extends StatelessWidget {
  const EmptyWishlist({super.key, required this.onBrowse});
  final VoidCallback onBrowse;

  @override
  Widget build(BuildContext context) => Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 34),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(Images.wishlist, height: 72, color: kAccentYellow),
              const SizedBox(height: 18),
              Text('Your wishlist is empty',
                  style: textBold.copyWith(color: kTextDark, fontSize: 18)),
              const SizedBox(height: 8),
              Text('Browse products and save them for later',
                  style: textBold.copyWith(color: kTextDark),
                  textAlign: TextAlign.center),
              const SizedBox(height: 18),
              CustomButton(
                onPressed: onBrowse,
                buttonText: 'Browse Products',
                radius: 20,
                buttonWidth: 200,
              ),
            ],
          ),
        ),
      );
}
