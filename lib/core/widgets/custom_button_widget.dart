import 'package:flutter/material.dart';
import 'package:grocery_shop_app/core/constants/app_colors.dart';

import '../utils/styles.dart';
import '../utils/dimensions.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.buttonText,
    this.isBuy = false,
    this.isBorder = false,
    this.backgroundColor = kPrimaryBlue,
    this.radius,
    this.textColor,
    this.fontSize,
    this.leftIcon,
    this.borderColor,
    this.loadingColor = Colors.white,
    this.borderWidth,
    this.isLoading = false,
    this.buttonHeight = 56,
    this.buttonWidth = double.infinity,
    this.onPressed,
  });
  final void Function()? onPressed;
  final String? buttonText;
  final bool isBuy;
  final bool isBorder;
  final Color backgroundColor;
  final Color? textColor;
  final Color? borderColor;
  final Color? loadingColor;
  final double? radius;
  final double? fontSize;
  final String? leftIcon;
  final double? borderWidth;
  final bool isLoading;
  final double buttonHeight;
  final double buttonWidth;

  @override
  Widget build(BuildContext context) => ElevatedButton(
        onPressed: isLoading ? null :  onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: onPressed == null ? kMuted : backgroundColor,
          padding: const EdgeInsets.all(0),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        ),
        child: Container(
          width: buttonWidth,
          height: buttonHeight,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              border: isBorder
                  ? Border.all(
                      color: isBorder ? kPrimaryBlue : kMuted,
                      width: borderWidth ?? 1)
                  : null,
              color: onPressed == null ? kMuted : backgroundColor,
              borderRadius: BorderRadius.circular(radius != null
                  ? radius!
                  : isBorder
                      ? Dimensions.paddingSizeExtraSmall
                      : Dimensions.paddingSizeLarge)),
          child: isLoading
              ? Center(
                  child: SizedBox(
                  height: 24,
                  width: 24,
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(loadingColor!),
                    strokeWidth: 2.5,
                  ),
                ))
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (leftIcon != null)
                      Padding(
                        padding: const EdgeInsets.only(right: 5),
                        child: SizedBox(
                            width: 30,
                            child: Padding(
                              padding: const EdgeInsets.all(
                                  Dimensions.paddingSizeExtraSmall),
                              child: Image.asset(leftIcon!),
                            )),
                      ),
                    Flexible(
                      child: Text(
                        buttonText ?? '',
                        style: titilliumSemiBold.copyWith(
                            fontSize: fontSize ?? 16, color: textColor),
                      ),
                    ),
                  ],
                ),
        ),
      );
}
