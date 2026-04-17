import 'package:flutter/material.dart';
import '../../../../config/routes/app_routes.dart';
import '../../../../core/services/navigation_service.dart';
import '../widgets/onboarding_image.dart';
import '../widgets/onboarding_indicator.dart';
import '../widgets/get_started_button.dart';

class OnboardingV1Screen extends StatelessWidget {
  const OnboardingV1Screen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: const Color(0xFFF7F7F9),
        body: SafeArea(
          child: Center(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 32),
                  const OnboardingImage(size: 88),
                  const SizedBox(height: 48),
                  const Text(
                    'Your holiday\nshopping\ndelivered to your\nhome 🎄',
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                        height: 1.2),
                    textAlign: TextAlign.left,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    "There's something for everyone to enjoy with Sweet Shop Favourites",
                    style: TextStyle(
                        fontSize: 14, color: Colors.black54, height: 1.4),
                    textAlign: TextAlign.left,
                  ),
                  const SizedBox(height: 32),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: OnboardingIndicator(current: 0),
                  ),
                  const SizedBox(height: 44),
                  GetStartedButton(
                    background: const Color(0xFF2E4482),
                    text: Colors.white,
                    onPressed: () {
                      NavigationService.navigateTo(
                          AppRoutes.login); 
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}
