import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/dimensions.dart';
import '../../../../core/utils/styles.dart';
import '../../../../core/widgets/custom_asset_image_widget.dart';

class ProfileField extends StatelessWidget {
  const ProfileField({
    super.key,
    required this.controller,
    this.label,
    this.obscureText = false,
    this.inputType = TextInputType.text,
    this.inputAction = TextInputAction.next,
    this.capitalization = TextCapitalization.none,
    this.validator,
    this.nextFocus,
    this.focusNode,
    this.suffixIcon,
    this.required = false,
    this.isRequiredFill = false,
    this.isAmount = false,
    this.prefixColor,
    this.prefixHeight = 50,
    this.prefixIcon,
    this.prefixOnTap,
    this.titleText,
    this.hintText = '...',
    this.showLabelText = false,
    this.labelText, this.inputFormatters,
  });
  final TextEditingController controller;
  final String? label;
  final String? labelText;
  final String? titleText;
  final String? hintText;
  final bool showLabelText;

  final bool obscureText;
  final TextInputType inputType;
  final TextInputAction inputAction;
  final TextCapitalization capitalization;
  final FocusNode? nextFocus;
  final FocusNode? focusNode;
    final List<TextInputFormatter>? inputFormatters;

  final String? Function(String?)? validator;
  final Widget? suffixIcon;
  final bool required;
  final bool isRequiredFill;
  final bool isAmount;
  final Color? prefixColor;
  final double prefixHeight;
  final String? prefixIcon;
  final void Function()? prefixOnTap;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (titleText != null)
              RichText(
                  text: TextSpan(
                      text: titleText ?? '',
                      style: textBold.copyWith(color: kMuted),
                      children: [
                    if (isRequiredFill)
                      TextSpan(
                          text: ' *',
                          style: textBold.copyWith(
                              fontWeight: FontWeight.w500,
                              fontSize: 24,
                              color: errorColor))
                  ])),
            if (titleText != null) const SizedBox(height: 8),
            TextFormField(
              controller: controller,
              keyboardType: inputType,
              obscureText: obscureText,
              focusNode: focusNode,
              validator: validator,
              textInputAction: inputAction,
              cursorColor: kPrimaryBlue,
              textCapitalization: capitalization,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              inputFormatters: inputType == TextInputType.phone
                  ? <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp('[0-9+]'))
                    ]
                  : isAmount
                      ? [FilteringTextInputFormatter.allow(RegExp('[0-9.]'))]
                      : inputFormatters,
              decoration: InputDecoration(
                labelText: showLabelText ? labelText : null,
                label: Text.rich(TextSpan(children: [
                  TextSpan(
                      text: label ?? '',
                      style: textBold.copyWith(
                        color: kMuted,
                        fontSize: 15,
                      )),
                  if (required && label != null)
                    TextSpan(
                        text: ' *',
                        style: textMedium.copyWith(
                            color: errorColor, fontSize: 19))
                ])),
                labelStyle: textBold.copyWith(
                  color: kMuted,
                ),
                hintText: hintText,
                hintStyle: showLabelText
                    ? textRegular.copyWith(
                        fontSize: Dimensions.fontSizeDefault, color: kMuted)
                    : textRegular.copyWith(
                        fontSize: Dimensions.fontSizeDefault, color: kMuted),
                filled: true,
                fillColor: kLightGrayBg,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(
                      color: Color(0xFFE5E5E5),
                      width: .75,
                    )),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(
                      color: kPrimaryBlue,
                      width: .75,
                    )),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(
                      color: Color(0xFFE5E5E5),
                      width: .75,
                    )),
                errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(
                      color: errorColor,
                    )),
                focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(
                      color: errorColor,
                    )),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                suffixIcon: suffixIcon,
                prefixIcon: prefixIcon != null
                    ? InkWell(
                        onTap: prefixOnTap,
                        child: Container(
                            width: prefixHeight,
                            padding: const EdgeInsets.all(1),
                            decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(8),
                                    bottomLeft: Radius.circular(8))),
                            child: Center(
                              child: CustomAssetImageWidget(
                                  height: 24,
                                  width: 24,
                                  prefixIcon!,
                                  color: prefixColor ??
                                      kPrimaryBlue.withOpacity(.4)),
                            )),
                      )
                    : null,
                errorStyle: textBold.copyWith(
                  color: errorColor,
                  fontSize: 12,
                ),
              ),
              onFieldSubmitted: (text) => nextFocus != null
                  ? FocusScope.of(context).requestFocus(nextFocus)
                  : null,
              style: textMedium.copyWith(
                fontSize: 15,
                color: kTextDark.withOpacity(0.6),
              ),
            ),
          ],
        ),
      );
}
