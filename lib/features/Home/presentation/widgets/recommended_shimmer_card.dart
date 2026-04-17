import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/constants/app_colors.dart';

class RecommendedShimmerCard extends StatelessWidget {
  const RecommendedShimmerCard({super.key});

  @override
  Widget build(BuildContext context) => Container(
      width: 140,
      height: 194,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: kSoftBg,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Shimmer.fromColors(
        baseColor: kBaseColor,
        highlightColor: kHighlightColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            Center(
              child: Container(
                  width: 74,
                  height: 74,
                  decoration:
                      BoxDecoration(color: kBaseColor, shape: BoxShape.circle)),
            ),
            const SizedBox(height: 20),
            Divider(
              color: kBaseColor,
              thickness: 1.5,
            ),
            const SizedBox(height: 12),
            Container(
              width: 100,
              height: 13,
              decoration: BoxDecoration(
                color: kBaseColor,
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            const SizedBox(height: 5),
            Container(
              width: 80,
              height: 11,
              decoration: BoxDecoration(
                color: kBaseColor,
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.3),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(children: [
                Container(
                  width: 40,
                  height: 11,
                  decoration: BoxDecoration(
                    color: kBaseColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                const Spacer(),
                Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                        color: kBaseColor, shape: BoxShape.circle)),
              ]),
            )
          ],
        ),
      ),
    );
}
