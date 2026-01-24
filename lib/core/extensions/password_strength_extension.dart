import '../enums/password_strength.dart';

extension PasswordStrengthExtension on PasswordStrength {
  String get label {
    switch (this) {
      case PasswordStrength.weak:
        return 'Weak';
      case PasswordStrength.medium:
        return 'Medium';
      case PasswordStrength.strong:
        return 'Strong';
    }
  }

  double get progress {
    switch (this) {
      case PasswordStrength.weak:
        return 0.33;
      case PasswordStrength.medium:
        return 0.66;
      case PasswordStrength.strong:
        return 1;
    }
  }

  int get color {
    switch (this) {
      case PasswordStrength.weak:
        return 0xFFFF5252; // Red
      case PasswordStrength.medium:
        return 0xFFFF9800; // Orange
      case PasswordStrength.strong:
        return 0xFF4CAF50; // Green
    }
  }
}
