import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/constants/app_colors.dart';

class DealProductShimmerCard extends StatelessWidget {
  const DealProductShimmerCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) => Container(
        width: 164,
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
              Center(
                child: Container(
                    width: 98,
                    height: 98,
                    decoration:  BoxDecoration(
                        color: kBaseColor, shape: BoxShape.circle)),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                          color: kBaseColor,
                          borderRadius: BorderRadius.circular(6))),
                ],
              ),
              Container(width: 60, height: 15, color: Colors.black),
              const SizedBox(height: 6),
              Container(width: 140, height: 12, color: kBaseColor),
              const SizedBox(height: 3),
              Container(width: 65, height: 12, color: kBaseColor),
            ],
          ),
        ),
      );
}
