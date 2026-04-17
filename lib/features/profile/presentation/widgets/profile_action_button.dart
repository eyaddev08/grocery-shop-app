import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/constants/app_colors.dart';

class ProfileActionButton extends StatelessWidget {
  const ProfileActionButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isOutlined = false,
    this.color,
  });
  final String label;
  final VoidCallback onPressed;
  final bool isOutlined;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final buttonColor = color ?? kPrimaryBlue;
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: isOutlined
          ? OutlinedButton(
              onPressed: onPressed,
              style: OutlinedButton.styleFrom(
                foregroundColor: kPrimaryBlue.withOpacity(0.6),
                side: BorderSide(color: buttonColor),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
              child:
                  Text(label, style: GoogleFonts.poppins(color: buttonColor)),
            )
          : ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: buttonColor,
                foregroundColor: kSearchBlue,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
              child:
                  Text(label, style: GoogleFonts.poppins(color: Colors.white)),
            ),
    );
  }
}
