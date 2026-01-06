import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../utils/styles.dart';
import '../utils/dimensions.dart';
import '../utils/images.dart';
import 'custom_snackbar_widget.dart';

class CustomToast extends StatelessWidget {
  const CustomToast(
      {super.key,
      required this.text,
      this.backgroundColor = kPrimaryBlue,
      this.textColor = Colors.white,
      this.borderRadius = 12,
      this.padding = const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      required this.sanckBarType});
  final String text;
  final Color backgroundColor;
  final Color textColor;
  final double borderRadius;
  final EdgeInsets padding;
  final SnackBarType sanckBarType;

  @override
  Widget build(BuildContext context) => Material(
        color: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 40),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                color: sanckBarType == SnackBarType.success
                    ? kAccentYellow //  const Color(0xE608AE61)
                    : sanckBarType == SnackBarType.warning
                        ? const Color(0xE6334257)
                        : const Color(0xE6334257),
                borderRadius: BorderRadius.circular(borderRadius),
              ),
              padding: padding,
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                      sanckBarType == SnackBarType.success
                          ? Images.snackbarTickmark
                          : sanckBarType == SnackBarType.warning
                              ? Images.snackbarWarning
                              : Images.snackbarError,
                      width: 17,
                      height: 17
                      ),
                  const SizedBox(width: Dimensions.paddingSizeSmall),
                  Flexible(
                      child: Text(text,
                          style: titilliumSemiBold.copyWith(
                              fontSize: Dimensions.fontSizeDefault,
                              color: textColor),
                          maxLines: 3)),
                ],
              ),
            ),
          ),
        ),
      );
}
