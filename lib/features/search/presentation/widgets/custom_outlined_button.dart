import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/styles.dart';

class CustomOutlinedButton extends StatelessWidget {
  const CustomOutlinedButton({super.key, required this.onPressed});

  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) => OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        side: BorderSide(color: kPrimaryBlue.withOpacity(0.3)),
      ),
      child: Text('Clear',
          style: titilliumSemiBold.copyWith(fontSize: 16, color: kPrimaryBlue)),
    );
}
