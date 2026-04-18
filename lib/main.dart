import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'app.dart';
import 'config/di/injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize dependency injection (includes Hive.initFlutter())
  await di.init();

  

  // Set preferred orientations
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const GroceryShopApp());
}
