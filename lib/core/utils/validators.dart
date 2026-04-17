import '../enums/password_strength.dart';

class Validators {

   static String? email(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  static String? password(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters';
    }
    return null;
  }

  static PasswordStrength checkPasswordStrength(String password) {
    int strength = 0;
    bool hasUpper = false;
    bool hasLower = false;
    bool hasDigit = false;
    bool hasSymbol = false;

    for (final char in password.runes) {
      final c = String.fromCharCode(char);
      if (RegExp('[A-Z]').hasMatch(c)) hasUpper = true;
      if (RegExp('[a-z]').hasMatch(c)) hasLower = true;
      if (RegExp('[0-9]').hasMatch(c)) hasDigit = true;
      if (RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(c)) hasSymbol = true;
    }

    if (hasUpper) strength++;
    if (hasLower) strength++;
    if (hasDigit) strength++;
    if (hasSymbol) strength++;

    if (strength <= 1) return PasswordStrength.weak;
    if (strength <= 2) return PasswordStrength.medium;
    return PasswordStrength.strong;
  }

  static String? confirmPassword(String? value, String? password) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }
    if (value != password) {
      return 'Passwords do not match';
    }
    return null;
  }

  static String? name(String? value) {
    if (value == null || value.isEmpty) {
      return 'Name is required';
    }
    if (value.length < 2) {
      return 'Name must be at least 2 characters';
    }
    return null;
  }

  static String? code(String? value) {
    if (value == null || value.isEmpty) {
      return 'Code is required';
    }
    if (value.length != 6 || !RegExp(r'^\d+$').hasMatch(value)) {
      return 'Code must be 6 digits';
    }
    return null;
  }
   static String? orderId(String? value) {
    if (value == null || value.isEmpty) {
      return 'Order ID is required';
    }
    // if (value.length != 8 || !RegExp(r'^\d+$').hasMatch(value)) {
    //   return 'Order ID must be 8 digits';
    // }
    // if (value.length > 10) {
    //   return 'Order ID must be less than 10 digits';
    // }
    return null;
  }


  // Phone number validation
  static String? phone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    }

    // Remove all non-digit characters
    // final digitsOnly = value.replaceAll(RegExp(r'[^\d]'), '');

    // if (digitsOnly.length < 10) {
    //   return 'Phone number must be at least 10 digits';
    // }

    // if (digitsOnly.length > 15) {
    //   return 'Phone number must be less than 15 digits';
    // }

    return null;
  }

  // Required field validation
  static String? required(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return '$fieldName is required';
    }
    return null;
  }

  // Number validation
  static String? number(String? value, {String? fieldName}) {
    if (value == null || value.isEmpty) {
      return '${fieldName ?? 'Field'} is required';
    }

    final number = double.tryParse(value);
    if (number == null) {
      return 'Please enter a valid number';
    }

    return null;
  }

  // Positive number validation
  static String? positiveNumber(String? value, {String? fieldName}) {
    final numberValidationResult =
        Validators.number(value, fieldName: fieldName);
    if (numberValidationResult != null) {
      return numberValidationResult;
    }

    final number = double.parse(value!);
    if (number <= 0) {
      return '${fieldName ?? 'Number'} must be greater than 0';
    }

    return null;
  }

  // URL validation
  static String? url(String? value) {
    if (value == null || value.isEmpty) {
      return 'URL is required';
    }

    final urlRegex = RegExp(
        r'^https?:\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&//=]*)$');

    if (!urlRegex.hasMatch(value)) {
      return 'Please enter a valid URL';
    }

    return null;
  }

  // Credit card number validation (basic)
  static String? creditCard(String? value) {
    if (value == null || value.isEmpty) {
      return 'Credit card number is required';
    }

    // Remove spaces and dashes
    final digitsOnly = value.replaceAll(RegExp(r'[^\d]'), '');

    if (digitsOnly.length < 13 || digitsOnly.length > 19) {
      return 'Credit card number must be between 13 and 19 digits';
    }

    // Luhn algorithm validation
    if (!_isValidLuhn(digitsOnly)) {
      return 'Invalid credit card number';
    }

    return null;
  }

  // CVV validation
  static String? cvv(String? value) {
    if (value == null || value.isEmpty) {
      return 'CVV is required';
    }

    final digitsOnly = value.replaceAll(RegExp(r'[^\d]'), '');

    if (digitsOnly.length != 3 && digitsOnly.length != 4) {
      return 'CVV must be 3 or 4 digits';
    }

    return null;
  }

  // Expiry date validation (MM/YY format)
  static String? expiryDate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Expiry date is required';
    }

    final expiryRegex = RegExp(r'^(0[1-9]|1[0-2])\/([0-9]{2})$');
    if (!expiryRegex.hasMatch(value)) {
      return 'Please enter expiry date in MM/YY format';
    }

    final parts = value.split('/');
    final month = int.parse(parts[0]);
    final year = int.parse('20${parts[1]}');

    final now = DateTime.now();
    final expiryDate = DateTime(year, month);

    if (expiryDate.isBefore(now)) {
      return 'Credit card has expired';
    }

    return null;
  }

  // Address validation
  static String? address(String? value) {
    if (value == null || value.isEmpty) {
      return 'Address is required';
    }

    if (value.length < 5) {
      return 'Address must be at least 5 characters long';
    }

    if (value.length > 200) {
      return 'Address must be less than 200 characters';
    }

    return null;
  }

  // City validation
  static String? city(String? value) {
    if (value == null || value.isEmpty) {
      return 'City is required';
    }

    if (value.length < 2) {
      return 'City must be at least 2 characters long';
    }

    if (value.length > 50) {
      return 'City must be less than 50 characters';
    }

    return null;
  }
  // Country validation
  static String? country(String? value) {
    if (value == null || value.isEmpty) {
      return 'Country is required';
    }

    if (value.length < 2) {
      return 'Country must be at least 2 characters long';
    }

    if (value.length > 50) {
      return 'Country must be less than 50 characters';
    }

    return null;
  }
  // ZIP code validation
  static String? zipCode(String? value) {
    if (value == null || value.isEmpty) {
      return 'ZIP code is required';
    }

    final zipRegex = RegExp(r'^\d{5}(-\d{4})?$');
    if (!zipRegex.hasMatch(value)) {
      return 'Please enter a valid ZIP code';
    }

    return null;
  }

  // Luhn algorithm for credit card validation
  static bool _isValidLuhn(String cardNumber) {
    int sum = 0;
    bool alternate = false;

    for (int i = cardNumber.length - 1; i >= 0; i--) {
      int digit = int.parse(cardNumber[i]);

      if (alternate) {
        digit *= 2;
        if (digit > 9) {
          digit = (digit % 10) + 1;
        }
      }

      sum += digit;
      alternate = !alternate;
    }

    return (sum % 10) == 0;
  }
}
