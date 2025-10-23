import 'package:flutter/material.dart';
import 'package:grocery_shop_app/core/constants/app_colors.dart';

import '../utils/custom_themes.dart';
import '../utils/dimensions.dart';

class CustomButton extends StatelessWidget {
  // ignore: inference_failure_on_function_return_type
  final Function()? onTap;
  final String? buttonText;
  final bool isBuy;
  final bool isBorder;
  final Color? backgroundColor;
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

  const CustomButton({
    super.key,
    this.onTap,
    required this.buttonText,
    this.isBuy = false,
    this.isBorder = false,
    this.backgroundColor,
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
  });

  @override
  Widget build(BuildContext context) => TextButton(
        onPressed: isLoading ? null : onTap as void Function()?,
        style: TextButton.styleFrom(padding: const EdgeInsets.all(0)),
        child: Container(
          width: buttonWidth,
          height: buttonHeight,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              border: isBorder
                  ? Border.all(color: kPrimaryBlue, width: borderWidth ?? 1)
                  : null,
              color: onTap == null
                  ? Theme.of(context).disabledColor
                  : backgroundColor ??
                      (isBuy ? const Color(0xffFE961C) : kPrimaryBlue),
              borderRadius: BorderRadius.circular(radius != null
                  ? radius!
                  : isBorder
                      ? Dimensions.paddingSizeExtraSmall
                      : Dimensions.paddingSizeSmall)),
          child: isLoading
              ? Center(
                  child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 15,
                      width: 15,
                      child: CircularProgressIndicator(
                        valueColor:
                            AlwaysStoppedAnimation<Color>(loadingColor!),
                        strokeWidth: 2,
                      ),
                    ),
                    const SizedBox(width: Dimensions.paddingSizeSmall),
                    Text('Loading',
                        style: textBold.copyWith(color: loadingColor, fontFamily: 'Poppins')),
                  ],
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
                      child: Text(buttonText ?? '',
                          style: titilliumSemiBold.copyWith(
                            fontSize: fontSize ?? 16,
                            color: Colors.white,
                            fontFamily: 'Poppins'
                          )),
                    ),
                  ],
                ),
        ),
      );
}
