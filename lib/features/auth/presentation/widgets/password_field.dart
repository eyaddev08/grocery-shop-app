import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:grocery_shop_app/core/constants/app_colors.dart';
import 'package:grocery_shop_app/core/extensions/password_strength_extension.dart';
import '../../../../core/utils/styles.dart';
import '../../../../core/utils/validators.dart';

class PasswordField extends StatefulWidget {
  const PasswordField({
    super.key,
    required this.controller,
    this.errorText,
    this.onChanged,
    this.hintText,
    this.showStrengthMeter = false,
    this.focusNode,
    this.inputType = TextInputType.text,
  });
  final TextEditingController controller;
  final String? errorText;
  final ValueChanged<String>? onChanged;
  final String? hintText;
  final bool showStrengthMeter;
  final FocusNode? focusNode;
  final TextInputType inputType;

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _obscureText = true;
  bool isFocusActive = false;

  @override
  Widget build(BuildContext context) {
    final strength =
        widget.showStrengthMeter && widget.controller.text.isNotEmpty
            ? Validators.checkPasswordStrength(widget.controller.text)
            : null;

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.06),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.white.withOpacity(0.10)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.12),
                  blurRadius: 18,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: TextFormField(
              controller: widget.controller,
              obscureText: _obscureText,
              focusNode: widget.focusNode,
              cursorColor: kAccentYellow,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                hintText: widget.hintText ?? 'Password',
                hintStyle: textBold.copyWith(color: kTextGray),
                prefixIcon: Container(
                  margin: const EdgeInsets.all(8),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withOpacity(0.06),
                  ),
                  child: const Icon(Icons.lock_outline,
                      color: Colors.white70, size: 18),
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                      _obscureText
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                      color: Colors.white70),
                  onPressed: () => setState(() => _obscureText = !_obscureText),
                  splashRadius: 20,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.white.withOpacity(0.3)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.white.withOpacity(0.03)),
                ),
                filled: true,
                fillColor: Colors.transparent,
                errorText: widget.errorText,
                errorStyle: textBold.copyWith(
                  color: errorColor,
                  fontSize: 12,
                ),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              ),
              style: textBold.copyWith(color: kLightGrayBg),
              validator: Validators.password,
              onChanged: widget.onChanged,
            ),
          ),
        ),
      ),
      if (strength != null && widget.showStrengthMeter) ...[
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Container(
                  height: 6,
                  color: Colors.white.withOpacity(0.08),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      final w = constraints.maxWidth * strength.progress;
                      return Stack(
                        children: [
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 400),
                            width: w,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  const Color(0xFFF9B023).withOpacity(0.98),
                                  Color(strength.color).withOpacity(0.98),
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Text(
              strength.label,
              style: textBold.copyWith(
                fontSize: 12,
                color: Color(strength.color),
              ),
            ),
          ],
        ),
      ],
    ]);
  }
}
