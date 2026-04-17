
import 'package:flutter/material.dart';
import 'package:grocery_shop_app/core/constants/app_colors.dart';

class LoadingOverlay extends StatelessWidget {
  final bool isLoading;
  final Widget child;

  const LoadingOverlay({
    super.key,
    required this.isLoading,
    required this.child,
  });

  @override
  Widget build(BuildContext context) => Stack(
        children: [
          child,
          if (isLoading)
            ColoredBox(
              color: Colors.black.withOpacity(0.3),
              child: const Center(
                child: CircularProgressIndicator(color: kAccentYellow),
              ),
            ),
        ],
      );
}
