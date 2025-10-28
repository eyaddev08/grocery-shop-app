import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/images.dart';

class AddNewAddressCard extends StatelessWidget {
  const AddNewAddressCard({super.key, required this.onTap});
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: onTap,
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 8),
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 18),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: const Color(0xFFF7F8FA), width: 2),
            color: Colors.white,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: kAccentYellow)),
                child: Center(
                    child: Image.asset(Images.addIcon,
                        color: kAccentYellow, height: 22)),
              ),
              const SizedBox(width: 12),
              Text('Add New Address',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: kTextDark.withOpacity(0.9),
                  )),
            ],
          ),
        ),
      );
}
