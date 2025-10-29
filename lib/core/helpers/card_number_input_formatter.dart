import 'package:flutter/services.dart';

class CardNumberInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var digits = newValue.text.replaceAll(' ', '');
    if (digits.length > 19) digits = digits.substring(0, 19);
    final parts = <String>[];
    for (var i = 0; i < digits.length; i += 4) {
      parts.add(
          digits.substring(i, (i + 4 > digits.length) ? digits.length : i + 4));
    }
    final newText = parts.join(' ');
    return TextEditingValue(
        text: newText,
        selection: TextSelection.collapsed(offset: newText.length));
  }
}