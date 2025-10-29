class ValidateCheck {
  static String? validateEmail(String? value) {
    const pattern = r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
        r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
        r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
        r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
        r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
        r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
        r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
    final kEmailValid = RegExp(pattern);
    final bool isValid = kEmailValid.hasMatch(value.toString());
    if (value!.isEmpty) {
      return '\u26A0 ${'Email is required'}';
    } else if (isValid == false) {
      return '\u26A0 ${"Enter valid email address"}';
    }
    return null;
  }

  static String? validateEmptyText(String? value, String? message) {
    if (value == null || value.isEmpty) {
      return 'This field is required';
    }
    return null;
  }

  static String? validatePassword(String? value, String? message) {
    if (value == null || value.isEmpty) {
      return 'This field is required';
    } else if (value.length < 8) {
      return 'Minimum password is 8 character';
    }
    return null;
  }

  static String? validateConfirmPassword(String? value, String? password) {
    if (value == null || value.isEmpty) {
      return 'Confirm password must be required';
    } else if (value != password) {
      return 'Confirm password not matched';
    }
    return null;
  }

  static String? nonEmpty(String? v, String msg) =>
      (v == null || v.trim().isEmpty) ? msg : null;

  static String? cardValidator(String? v) {
    final s = v?.replaceAll(' ', '') ?? '';
    if (s.isEmpty) return 'Enter card number';
    if (s.length < 12) return 'Invalid card';
    return null;
  }

  static String? expiryValidator(String? v) {
    if (v == null || v.trim().isEmpty) return 'Enter expiry';
    final parts = v.split('/');
    if (parts.length != 2) return 'Format MM/YY';
    final mm = int.tryParse(parts[0]);
    final yy = int.tryParse(parts[1]);
    if (mm == null || yy == null) return 'Invalid expiry';
    if (mm < 1 || mm > 12) return 'Invalid month';
    return null;
  }

  static String? cvcValidator(String? v) {
    if (v == null || v.trim().isEmpty) return 'Enter CVC';
    if (v.trim().length < 3) return 'Invalid CVC';
    return null;
  }
}
