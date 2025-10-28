import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/custom_button_widget.dart';

class EmptyCartState extends StatelessWidget {
  const EmptyCartState({super.key});

  @override
  Widget build(BuildContext context) => Expanded(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.shopping_cart_outlined, size: 84, color: kMuted),
              const SizedBox(height: 12),
              const Text('Your cart is empty',
                  style: TextStyle(
                      color: Color(0xFF1E222B),
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Poppins')),
              const SizedBox(height: 6),
              const Text('Add items to collect them here.',
                  style: TextStyle(color: kMuted, fontFamily: 'Poppins')),
              const SizedBox(height: 16),
              CustomButton(
                buttonText: 'Shop now',
                buttonWidth: 142,
                onTap: () => Navigator.pop(context),
              ),
            ],
          ),
        ),
      );
}
