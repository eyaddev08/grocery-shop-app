import 'package:flutter/material.dart';
import 'package:grocery_shop_app/core/constants/app_colors.dart';
import 'package:shimmer/shimmer.dart';

class CategoryShimmerCard extends StatelessWidget {
  const CategoryShimmerCard({super.key});

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(12);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: SizedBox(
        height: 167,
        child: Shimmer.fromColors(
          baseColor: kBaseColor,
          highlightColor: kHighlightColor,
          child: Row(
            children: [
              Container(
                width: 137,
                height: 167,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: borderRadius,
                ),
                child: Center(
                  child: Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: kBaseColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 11),
                    Container(
                      width: double.infinity,
                      height: 20,
                      margin: const EdgeInsets.only(right: 40),
                      decoration: BoxDecoration(
                        color: kBaseColor,
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      width: 140,
                      height: 18,
                      decoration: BoxDecoration(
                        color: kBaseColor,
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    const SizedBox(height: 47),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        width: 100,
                        height: 14,
                        decoration: BoxDecoration(
                          color: kBaseColor,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        Container(
                          width: 80,
                          height: 22,
                          decoration: BoxDecoration(
                            color: kBaseColor,
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          width: 40,
                          height: 18,
                          decoration: BoxDecoration(
                            color: kBaseColor,
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
