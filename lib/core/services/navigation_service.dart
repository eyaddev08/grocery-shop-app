import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../config/routes/app_routes.dart';

class NavigationService {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static Future<dynamic> navigateTo(String routeName, {Object? arguments}) {
    return navigatorKey.currentState!
        .pushNamed(routeName, arguments: arguments);
  }

  static Future<dynamic> navigateAndReplace(String routeName,
      {Object? arguments}) {
    return navigatorKey.currentState!
        .pushReplacementNamed(routeName, arguments: arguments);
  }

  static Future<dynamic> navigateAndClearStack(String routeName,
      {Object? arguments}) {
    return navigatorKey.currentState!.pushNamedAndRemoveUntil(
      routeName,
      (Route<dynamic> route) => false,
      arguments: arguments,
    );
  }

  static void goBack() {
    return navigatorKey.currentState!.pop();
  }

  static bool canGoBack() {
    return navigatorKey.currentState!.canPop();
  }

  // // Splash screen specific navigation logic
  // static Future<void> navigateFromSplash() async {
  //   // TODO: Add authentication check logic here
  //   // For now, we'll simulate a delay and navigate to home

  //   // Simulate checking user authentication status
  //   await Future<void>.delayed(const Duration(milliseconds: 1000));

  //   // Check if user is logged in (this should be replaced with actual auth check)
  //   bool isLoggedIn = false; // This should come from your auth service

  //   if (isLoggedIn) {
  //     await navigateAndClearStack(AppRoutes.home);
  //   } else {
  //     await navigateAndClearStack(AppRoutes.login);
  //   }
  // }

  static Future<void> navigateFromSplash() async {
    final prefs = await SharedPreferences.getInstance();

    /// [onboardingSeen] = true إذا تم عرض الـ onBoarding مسبقًا
    bool onboardingSeen = prefs.getBool('onboarding_seen') ?? false;

    if (!onboardingSeen) {
      // أول مرة يفتح التطبيق
      await prefs.setBool('onboarding_seen', true);
      await navigateAndClearStack(AppRoutes.onboarding);
      return;
    }

    // إذا تم فتح التطبيق مسبقًا، افحص حالة الدخول
    /// (يمكنك تعديل شرط isLoggedIn كما يناسب مشروعك)
    bool isLoggedIn = false; // this should come from your auth/local-storage

    if (isLoggedIn) {
      await navigateAndClearStack(AppRoutes.layout);
    } else {
      await navigateAndClearStack(AppRoutes.login);
    }
  }

  // Handle deep linking
  static Future<void> handleDeepLink(String? link) async {
    if (link == null) return;

    // Parse the deep link and navigate accordingly
    switch (link) {
      case '/layout':
        await navigateAndClearStack(AppRoutes.layout);
        break;
      case '/login':
        await navigateAndClearStack(AppRoutes.login);
        break;
      default:
        await navigateAndClearStack(AppRoutes.layout);
        break;
    }
  }
}
