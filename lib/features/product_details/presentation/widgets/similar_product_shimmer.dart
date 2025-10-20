import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';

class SimilarProductShimmer extends StatelessWidget {
  const SimilarProductShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 156,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => Container(
          width: 140,
          decoration: BoxDecoration(
            color: kSoftBg,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    color: kSoftBg,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(14)),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        width: 80,
                        height: 12,
                        decoration: BoxDecoration(
                            color: baseColor,
                            borderRadius: BorderRadius.circular(6))),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Container(
                            width: 40,
                            height: 14,
                            decoration: BoxDecoration(
                                color: baseColor,
                                borderRadius: BorderRadius.circular(6))),
                        const Spacer(),
                        Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                                color: baseColor, shape: BoxShape.circle)),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemCount: 5,
      ),
    );

    const SizedBox(height: 24);
  }
}
