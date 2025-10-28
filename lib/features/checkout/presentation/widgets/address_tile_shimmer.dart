import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:grocery_shop_app/core/constants/app_colors.dart';

class AddressTileShimmer extends StatelessWidget {
  const AddressTileShimmer({super.key});

  @override
  Widget build(BuildContext context) => Shimmer.fromColors(
      baseColor: kBaseColor,
      highlightColor: kHighlightColor,
      child: Container(
        width: 327,
        height: 96,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFF7F8FA), width: 2),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 120,
                    height: 14,
                    decoration: BoxDecoration(
                      color: kBaseColor,
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    width: 180,
                    height: 14,
                    decoration: BoxDecoration(
                      color: kBaseColor,
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Container(
              width: 22,
              height: 22,
              decoration: BoxDecoration(
                color: kBaseColor,
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xFFF7F8FA)),
              ),
            ),
          ],
        ),
      ),
    );
}
