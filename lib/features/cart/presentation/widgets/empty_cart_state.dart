import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/styles.dart';
import '../../../../core/widgets/custom_button_widget.dart';

class EmptyCartState extends StatelessWidget {
  const EmptyCartState({super.key});

  @override
  Widget build(BuildContext context) => Expanded(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.shopping_cart_outlined,
                  size: 100, color: kAccentYellow),
              const SizedBox(height: 12),
              Text('Your cart is empty',
                  style: textBold.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  )),
              const SizedBox(height: 6),
              Text('Add items to collect them here.',
                  style: textBold.copyWith(color: kMuted)),
              const SizedBox(height: 16),
              CustomButton(
                buttonText: 'Shop now',
                buttonWidth: 142,
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
        ),
      );
}
