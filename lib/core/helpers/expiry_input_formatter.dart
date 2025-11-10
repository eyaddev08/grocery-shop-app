import 'package:flutter/services.dart';

class ExpiryInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var digits = newValue.text.replaceAll('/', '');
    if (digits.length > 4) digits = digits.substring(0, 4);
    if (digits.length >= 3) {
      final mm = digits.substring(0, 2);
      final yy = digits.substring(2);
      final formatted = '$mm/$yy';
      return TextEditingValue(
          text: formatted,
          selection: TextSelection.collapsed(offset: formatted.length));
    } else {
      return TextEditingValue(
          text: digits,
          selection: TextSelection.collapsed(offset: digits.length));
    }
  }
}