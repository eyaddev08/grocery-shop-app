import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:grocery_shop_app/core/constants/app_colors.dart';

import '../utils/styles.dart';
import '../utils/dimensions.dart';
import 'custom_asset_image_widget.dart';

class CustomTextFieldWidget extends StatefulWidget {
  final String? hintText;
  final String? titleText;
  final String? labelText;
  final TextAlign textAlign;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final FocusNode? nextFocus;
  final TextInputType inputType;
  final TextInputAction inputAction;
  final bool isPassword;
  final bool isAmount;
  final bool showCodePicker;
  final bool isRequiredFill;
  final bool readOnly;
  final bool filled;
  final void Function()? onTap;
  final void Function()? suffixOnTap;
  final void Function()? suffix2OnTap;
  final void Function()? prefixOnTap;
  final void Function(String value)? onChanged;
  final String? Function(String?)? validator;
  final bool isEnabled;
  final int maxLines;
  final TextCapitalization capitalization;
  final double borderRadius;
  final String? prefixIcon;
  final String? suffixIcon;
  final String? suffixIcon2;
  final double suffixIconSize;
  final bool showBorder;
  final bool showLabelText;
  final String? countryDialCode;
  final double prefixHeight;
  final Color borderColor;
  final List<TextInputFormatter>? inputFormatters;
  final void Function()? onCountryChanged;
  final bool required;
  final Color? prefixColor;
  final Color? suffixColor;
  final bool isShowBorder;
  final bool isToolTipSuffix;
  final String? toolTipMessage;
  final GlobalKey? toolTipKey;
  final TextStyle? labelTextStyle;

  const CustomTextFieldWidget(
      {super.key,
      this.hintText = '...',
      this.controller,
      this.focusNode,
      this.titleText,
      this.nextFocus,
      this.isEnabled = true,
      this.borderColor = const Color(0xFFBFBFBF),
      this.inputType = TextInputType.text,
      this.inputAction = TextInputAction.next,
      this.maxLines = 1,
      this.onChanged,
      this.onTap,
      this.prefixIcon,
      this.suffixIcon,
      this.suffixIconSize = 24,
      this.capitalization = TextCapitalization.none,
      this.readOnly = false,
      this.isPassword = false,
      this.isAmount = false,
      this.showCodePicker = false,
      this.isRequiredFill = false,
      this.showLabelText = true,
      this.showBorder = false,
      this.filled = true,
      this.borderRadius = 8,
      this.prefixHeight = 50,
      this.countryDialCode,
      this.onCountryChanged,
      this.validator,
      this.inputFormatters,
      this.labelText,
      this.textAlign = TextAlign.start,
      this.required = false,
      this.suffixOnTap,
      this.suffix2OnTap,
      this.prefixOnTap,
      this.prefixColor,
      this.suffixColor,
      this.suffixIcon2,
      this.isShowBorder = false,
      this.isToolTipSuffix = false,
      this.toolTipMessage,
      this.toolTipKey,
      this.labelTextStyle});

  @override
  State<CustomTextFieldWidget> createState() => _CustomTextFieldWidgetState();
}

class _CustomTextFieldWidgetState extends State<CustomTextFieldWidget> {
  bool _obscureText = true;
  bool isFocusActive = false;

  @override
  void initState() {
    // widget.toolTipKey != null ? showAndCloseTooltip(widget.toolTipKey) : null;
    super.initState();
  }

  // Future showAndCloseTooltip(var key) async {
  //   await Future<void>.delayed(const Duration(milliseconds: 10));
  //   final dynamic tooltip = key.currentState;
  //   tooltip?.ensureTooltipVisible();
  //   await Future<void>.delayed(const Duration(milliseconds: 10));
  //   tooltip?.deactivate();
  // }

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (widget.titleText != null)
            RichText(
                text: TextSpan(
                    text: widget.titleText ?? '',
                    style: textMedium.copyWith(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: const Color(0xFF202532)),
                    children: [
                  if (widget.isRequiredFill)
                    TextSpan(
                        text: ' *',
                        style: textMedium.copyWith(
                            fontWeight: FontWeight.w500,
                            fontSize: 24,
                            color: errorColor))
                ])),
          if (widget.titleText != null) const SizedBox(height: 8),
          TextFormField(
              maxLines: widget.maxLines,
              controller: widget.controller,
              focusNode: widget.focusNode,
              validator: widget.validator,
              textAlign: widget.textAlign,
              readOnly: widget.readOnly,
              onTap: widget.onTap,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              style: textMedium.copyWith(
                fontSize: 14,
                color: kTextDark.withOpacity(0.9),
              ),
              textInputAction: widget.inputAction,
              keyboardType: widget.inputType,
              cursorColor: kPrimaryBlue,
              textCapitalization: widget.capitalization,
              enabled: widget.isEnabled,
              autofillHints: widget.inputType == TextInputType.name
                  ? [AutofillHints.name]
                  : widget.inputType == TextInputType.emailAddress
                      ? [AutofillHints.email]
                      : widget.inputType == TextInputType.phone
                          ? [AutofillHints.telephoneNumber]
                          : widget.inputType == TextInputType.streetAddress
                              ? [AutofillHints.fullStreetAddress]
                              : widget.inputType == TextInputType.url
                                  ? [AutofillHints.url]
                                  : widget.inputType ==
                                          TextInputType.visiblePassword
                                      ? [AutofillHints.password]
                                      : null,
              obscureText: widget.isPassword ? _obscureText : false,
              inputFormatters: widget.inputType == TextInputType.phone
                  ? <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp('[0-9+]'))
                    ]
                  : widget.isAmount
                      ? [FilteringTextInputFormatter.allow(RegExp('[0-9.]'))]
                      : widget.inputFormatters,
              decoration: InputDecoration(
                floatingLabelBehavior: FloatingLabelBehavior.always,

                contentPadding:
                    const EdgeInsets.all(Dimensions.fontSizeDefault),
                alignLabelWithHint: true,
                border: UnderlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: widget.borderColor,
                      width: widget.showBorder ? 0 : .75,
                    )),
                focusedBorder: UnderlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: kPrimaryBlue, //widget.borderColor,
                      width: widget.showBorder ? 0 : .75,
                    )),

                enabledBorder: UnderlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: widget.borderColor,
                      width: widget.showBorder ? 0 : .75,
                    )),
                errorBorder: UnderlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: errorColor,
                      width: widget.showBorder ? 0 : 1,
                    )),
                focusedErrorBorder: UnderlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: widget.borderColor,
                      width: widget.showBorder ? 0 : .75,
                    )),

                floatingLabelStyle: widget.showLabelText
                    ? textRegular.copyWith(
                        fontSize: Dimensions.fontSizeSmall, color: kMuted)
                    : null,
                fillColor: kLightGrayBg,
                filled: widget.filled,
                // labelText : widget.showLabelText? widget.labelText?? widget.hintText : null,
                labelStyle: widget.showLabelText
                    ? textBold.copyWith(
                        color: kMuted,
                        fontSize: 25,
                      )
                    : null,
                errorStyle: textBold.copyWith(
                  color: errorColor,
                  fontSize: 12,
                ),
                label: Text.rich(TextSpan(children: [
                  TextSpan(
                      text: widget.labelText ?? '',
                      style: widget.labelTextStyle ??
                          textBold.copyWith(
                            color: kMuted,
                            fontSize: 18,
                          )),
                  if (widget.required && widget.labelText != null)
                    TextSpan(
                        text: ' *',
                        style: textMedium.copyWith(
                            color: errorColor, fontSize: 23))
                ])),
                hintText: widget.hintText,
                hintStyle: widget.showLabelText
                    ? textRegular.copyWith(
                        fontSize: Dimensions.fontSizeDefault, color: kMuted)
                    : textRegular.copyWith(
                        fontSize: Dimensions.fontSizeDefault, color: kMuted),
                prefixIcon: widget.prefixIcon != null
                    ? InkWell(
                        onTap: widget.prefixOnTap,
                        child: Container(
                            width: widget.prefixHeight,
                            padding: const EdgeInsets.all(1),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft:
                                        Radius.circular(widget.borderRadius),
                                    bottomLeft:
                                        Radius.circular(widget.borderRadius))),
                            child: Center(
                              child: CustomAssetImageWidget(
                                  height: widget.suffixIconSize,
                                  width: widget.suffixIconSize,
                                  widget.prefixIcon!,
                                  color: widget.prefixColor ??
                                      kPrimaryBlue.withOpacity(.4)),
                            )),
                      )
                    : null,

                suffixIcon: widget.isToolTipSuffix
                    ? Tooltip(
                        key: widget.toolTipKey,
                        preferBelow: false,
                        margin: const EdgeInsets.only(
                            top: Dimensions.paddingSizeSmall),
                        triggerMode: TooltipTriggerMode.manual,
                        message: widget.toolTipMessage ?? '',
                        child: IconButton(
                            onPressed: widget.suffixOnTap,
                            icon: Image.asset(
                              widget.suffixIcon!,
                              width: 25,
                              height: 25,
                            )),
                      )
                    : InkWell(
                        onTap: () {},
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (widget.suffixIcon2 != null)
                              SizedBox(
                                  width: 30,
                                  height: 30,
                                  child: Padding(
                                      padding: const EdgeInsets.all(
                                          Dimensions.paddingSizeExtraSmall),
                                      child: InkWell(
                                        onTap: widget.suffix2OnTap,
                                        child: Image.asset(widget.suffixIcon2!),
                                      )))
                            else
                              const SizedBox.shrink(),
                            if (widget.isPassword)
                              IconButton(
                                  icon: Icon(
                                    _obscureText
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    color: Theme.of(context)
                                        .primaryColor
                                        .withOpacity(.6),
                                  ),
                                  onPressed: _toggle)
                            else
                              widget.suffixIcon != null
                                  ? Row(
                                      children: [
                                        const SizedBox(
                                            width: Dimensions
                                                .paddingSizeExtraSmall),
                                        SizedBox(
                                            width: 35,
                                            height: 35,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                top: Dimensions
                                                    .paddingSizeExtraExtraSmall,
                                                left: Dimensions
                                                    .paddingSizeExtraExtraSmall,
                                                bottom: Dimensions
                                                    .paddingSizeExtraExtraSmall,
                                                right:
                                                    Dimensions.paddingSizeSmall,
                                              ),
                                              child: InkWell(
                                                  onTap: widget.suffixOnTap,
                                                  child: Image.asset(
                                                      widget.suffixIcon!,
                                                      color:
                                                          widget.suffixColor ??
                                                              Theme.of(context)
                                                                  .hintColor)),
                                            )),
                                        const SizedBox(
                                            width: Dimensions
                                                .paddingSizeExtraSmall),
                                      ],
                                    )
                                  : const SizedBox.shrink(),
                          ],
                        ),
                      ),
              ),
              onFieldSubmitted: (text) => widget.nextFocus != null
                  ? FocusScope.of(context).requestFocus(widget.nextFocus)
                  : null,
              onChanged: (value) {
                if (widget.onChanged != null) {
                  widget.onChanged!(value);
                }
              }),
        ],
      );

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }
}
