import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key, required this.title,
  });
  final String title;

  @override
  Widget build(BuildContext context) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: Row(
            children: [
              Container(
                width: 45,
                height: 45,
                decoration: BoxDecoration(
                  color: textDark.withOpacity(0.06),
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  padding: EdgeInsets.zero,
                  icon:
                      const Icon(Icons.chevron_left, size: 20, color: textDark),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              const SizedBox(width: 16),
               SizedBox(
                width: 143,
                child: Text(title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: textDark,
                    fontSize: 20,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                    height: 1.50,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}
