import 'package:flutter/material.dart';

class OnboardingIndicator extends StatelessWidget {

  const OnboardingIndicator({
    super.key,
    required this.current,
    this.total = 3,
    this.activeColor = const Color(0xFF2E4482),
    this.inactiveColor = const Color(0xFFDFE3E8),
  });
  final int current;
  final int total;
  final Color activeColor;
  final Color inactiveColor;

  @override
  Widget build(BuildContext context) => Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(total, (index) {
        final isActive = index == current;
        return Container(
          width: 24,
          height: 4,
          margin: const EdgeInsets.symmetric(horizontal: 2),
          decoration: BoxDecoration(
            color: isActive ? activeColor : inactiveColor,
            borderRadius: BorderRadius.circular(2),
          ),
        );
      }),
    );
}