import 'package:flutter/material.dart';
import '../../../../config/routes/app_routes.dart';
import '../../../../core/services/navigation_service.dart';
import '../widgets/onboarding_image.dart';
import '../widgets/onboarding_indicator.dart';
import '../widgets/get_started_button.dart';

class OnboardingV2Screen extends StatelessWidget {
  const OnboardingV2Screen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: const Color(0xFF2E4482),
        body: SafeArea(
          child: Center(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: const Color(0xFF2E4482),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 24),
                  const Text(
                    'Your holiday\nshopping\ndelivered to your\nhome 🎄',
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        height: 1.2),
                    textAlign: TextAlign.left,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "There's something for everyone to enjoy with Sweet Shop Favourites",
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.white.withOpacity(0.85),
                        height: 1.4),
                    textAlign: TextAlign.left,
                  ),
                  const SizedBox(height: 16),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: OnboardingIndicator(
                      current: 0,
                      activeColor: Colors.white,
                      inactiveColor: Colors.white30,
                    ),
                  ),
                  const Spacer(),
                  const Center(child: OnboardingImage(size: 88)),
                  const Spacer(),
                  GetStartedButton(
                    background: Colors.white,
                    text: const Color(0xFF2E4482),
                    onPressed: () {
                      NavigationService.navigateAndClearStack(
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
