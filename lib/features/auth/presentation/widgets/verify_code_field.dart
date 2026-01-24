import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/styles.dart';

class VerifyCodeField extends StatelessWidget {
  const VerifyCodeField(
      {super.key,
      required this.index,
      this.onChanged,
      required this.controllers,
      required this.focusNodes});
  final int index;
  final List<TextEditingController> controllers;
  final List<FocusNode> focusNodes;
  // ignore: inference_failure_on_function_return_type
  final Function(String)? onChanged;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2),
        child: SizedBox(
          width: 45,
          height: 53,
          child: TextField(
            controller: controllers[index],
            focusNode: focusNodes[index],
            textAlign: TextAlign.center,
            cursorColor: kAccentYellow,
            keyboardType: TextInputType.number,
            maxLength: 1,
            style: titilliumBold.copyWith(
              fontSize: 21,
            ),
            decoration: InputDecoration(
              counterText: '',
              fillColor: Colors.transparent,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey[300]!),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: kPrimaryBlue, width: 2),
              ),
              // errorText:
              //     _codeError != null && index == 0
              //         ? _codeError
              //         : null,
              errorStyle: textBold.copyWith(
                color: errorColor,
                fontSize: 12,
              ),
            ),
            onChanged: onChanged,
          ),
        ),
      );
}
