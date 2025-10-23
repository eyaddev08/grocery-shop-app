import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/dimensions.dart';

class CartItemShimmer extends StatelessWidget {
  const CartItemShimmer({super.key});

  @override
  Widget build(BuildContext context) => Shimmer.fromColors(
        baseColor: baseColor,
        highlightColor: highlightColor,
        child: Column(
          children: [
            Row(
              children: [
                const SizedBox(width: 12),
                Container(width: 56, height: 56, color: Colors.white),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(height: 14, width: 120, color: Colors.white),
                      const SizedBox(height: 8),
                      Container(height: 12, width: 60, color: Colors.white),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Row(
                  children: [
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius:
                            BorderRadius.circular(Dimensions.radiusExtraLarge),
                        child: Container(
                          width: 35,
                          height: 35,
                          decoration: const ShapeDecoration(
                            color: Colors.white,
                            shape: OvalBorder(),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(width: 24, height: 24, color: Colors.white),
                    const SizedBox(width: 8),
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius:
                            BorderRadius.circular(Dimensions.radiusExtraLarge),
                        child: Container(
                          width: 35,
                          height: 35,
                          decoration: const ShapeDecoration(
                            color: Colors.white,
                            shape: OvalBorder(),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 12),
            Container(height: 1, color: Colors.white),
          ],
        ),
      );
}
