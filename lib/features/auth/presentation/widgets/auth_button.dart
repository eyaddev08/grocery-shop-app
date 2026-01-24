// ملف مسؤول عن زر رئيسي قابل لإعادة الاستخدام في شاشات المصادقة.

import 'package:flutter/material.dart';
import 'package:grocery_shop_app/core/constants/app_colors.dart';

import '../../../../core/utils/styles.dart';

class AuthButton extends StatelessWidget {
  const AuthButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.backgroundColor,
    this.textColor,
  });
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final Color? backgroundColor;
  final Color? textColor;

  @override
  Widget build(BuildContext context) => SizedBox(
        width: double.infinity,
        height: 56,
        child: ElevatedButton(
          onPressed: isLoading ? null : onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: backgroundColor ?? kAccentYellow,
            foregroundColor: textColor ?? Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: const BorderSide(color: kPrimaryBlue)),
            elevation: 0,
          ),
          child: isLoading
              ? SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(
                        textColor ?? Colors.white),
                  ),
                )
              : Text(
                  text,
                  style: textBold.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: kPrimaryBlue),
                ),
        ),
      );
}
