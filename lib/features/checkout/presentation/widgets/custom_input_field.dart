import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/styles.dart';

typedef FieldValidator = String? Function(String? value);

class CustomInputField extends StatefulWidget {
  const CustomInputField({
    super.key,
    this.controller,
    required this.label,
    this.validator,
    this.minLines = 1,
    this.maxLines = 1,
    this.keyboardType = TextInputType.text,
    this.inputFormatters,
    this.prefix,
    this.suffix,
    this.filled = false,
    this.contentPadding,
    this.enabled = true,
  });
  final TextEditingController? controller;
  final String label;
  final FieldValidator? validator;
  final int minLines;
  final int maxLines;
  final TextInputType keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final Widget? prefix;
  final Widget? suffix;
  final bool filled;
  final EdgeInsetsGeometry? contentPadding;
  final bool enabled;

  @override
  _CustomInputFieldState createState() => _CustomInputFieldState();
}

class _CustomInputFieldState extends State<CustomInputField> {
  late final TextEditingController _controller;
  String? _errorText;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _validate(_controller.text));

    _controller.addListener(() {
      _validate(_controller.text);
    });
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  String? _defaultValidator(String? v) {
    if (v == null || v.trim().isEmpty) return 'Enter address';
    return null;
  }

  void _validate(String value) {
    final validator = widget.validator ?? _defaultValidator;
    final newError = validator(value);
    if (newError != _errorText) {
      setState(() {
        _errorText = newError;
      });
    }
  }

  InputDecoration _decoration() => InputDecoration(
        labelText: widget.label,
        labelStyle: textBold.copyWith(
          color: kMuted,
          fontSize: 18,
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        filled: widget.filled,
        contentPadding: widget.contentPadding ??
            const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: kFieldBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: kPrimaryBlue, width: 1.2),
        ),
        errorText: _errorText,
        prefixIcon: widget.prefix != null
            ? Padding(
                padding: const EdgeInsets.only(left: 12, right: 8),
                child: widget.prefix)
            : null,
        prefixIconConstraints: const BoxConstraints(),
        suffixIcon: widget.suffix != null
            ? Padding(
                padding: const EdgeInsets.only(left: 8, right: 12),
                child: widget.suffix)
            : null,
        errorStyle: const TextStyle(color: Colors.redAccent, fontSize: 12),
      );

  @override
  Widget build(BuildContext context) => TextFormField(
        controller: _controller,
        style: textRegular.copyWith(
            color: kTextDark, fontSize: 15, fontWeight: FontWeight.w300),
        minLines: widget.minLines,
        maxLines: widget.maxLines,
        focusNode: widget.enabled ? FocusNode() : null,
        keyboardType: widget.keyboardType,
        inputFormatters: widget.inputFormatters,
        cursorColor: kPrimaryBlue,
        decoration: _decoration(),
        enabled: widget.enabled,
        validator: widget.validator ?? _defaultValidator,
        autovalidateMode: AutovalidateMode.always,
      );
}
