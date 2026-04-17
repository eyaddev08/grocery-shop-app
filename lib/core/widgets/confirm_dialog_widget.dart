import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../utils/styles.dart';
import '../utils/dimensions.dart';
import 'custom_button_widget.dart';

class ConfirmDialogWidget extends StatelessWidget {
  const ConfirmDialogWidget({
    super.key,
    this.isFailed = false,
    this.rotateAngle = 0,
    required this.icon,
    required this.title,
    required this.description,
    required this.onPressed,
    required this.onCancle,
    this.titleButton = 'remove',
  });
  final bool isFailed;
  final double rotateAngle;
  final IconData icon;
  final String? title;
  final String? titleButton;

  final String? description;
  final VoidCallback onPressed;
  final VoidCallback onCancle;

  @override
  Widget build(BuildContext context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        backgroundColor: kSoftBg,
        child: Padding(
          padding: const EdgeInsets.all(Dimensions.paddingSizeLarge),
          child: Stack(clipBehavior: Clip.none, children: [
            Positioned(
              left: 0,
              right: 0,
              top: -55,
              child: Container(
                height: 80,
                width: 80,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: isFailed ? errorColor : kAccentYellow,
                    shape: BoxShape.circle),
                child: Transform.rotate(
                    angle: rotateAngle,
                    child: Icon(icon, size: 40, color: Colors.white)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 40),
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                Text(title!,
                    style: robotoBold.copyWith(
                        fontSize: Dimensions.fontSizeLarge, color: kTextDark)),
                const SizedBox(height: Dimensions.paddingSizeSmall),
                Text(description!,
                    textAlign: TextAlign.center,
                    style: titilliumRegular.copyWith(
                        fontSize: Dimensions.fontSizeDefault, color: kMuted)),
                const SizedBox(height: Dimensions.paddingSizeLarge),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: Dimensions.paddingSizeExtraSmall),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                          width: 100,
                          child: CustomButton(
                              buttonText: 'Cancel',
                              radius: 12,
                              buttonHeight: 44,
                              fontSize: 13,
                              isBorder: true,
                              textColor: kSoftBg,
                              onPressed: onCancle)),
                      const SizedBox(
                        width: Dimensions.paddingSizeDefault,
                      ),
                      SizedBox(
                          width: 100,
                          child: CustomButton(
                            buttonText: titleButton,
                            radius: 12,
                            buttonHeight: 44,
                            fontSize: 13,
                            backgroundColor:
                                isFailed ? errorColor : kAccentYellow,
                            onPressed: onPressed,
                          ))
                    ],
                  ),
                )
              ]),
            ),
          ]),
        ),
      );
}
