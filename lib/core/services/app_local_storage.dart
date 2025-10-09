import 'package:shared_preferences/shared_preferences.dart';

class AppLocalStorage {
  static const String onboardingKey = 'hasSeenOnBoarding';

  static Future<void> setSeenOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(onboardingKey, true);
  }

  static Future<bool> hasSeenOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(onboardingKey) ?? false;
  }
}