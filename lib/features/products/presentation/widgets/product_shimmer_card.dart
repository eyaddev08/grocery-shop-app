
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ProductShimmerCard extends StatelessWidget {
  const ProductShimmerCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) => SizedBox(
        height: 194,
        child: Container(
          width: 160,
          height: 194,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: const Color(0xFFF7F8FA),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                      width: 98,
                      height: 98,
                      decoration: const BoxDecoration(
                          color: Colors.white, shape: BoxShape.circle)),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(6))),
                  ],
                ),
                const SizedBox(height: 12),
                Container(width: 60, height: 14, color: Colors.black),
                const SizedBox(height: 6),
                Container(width: 90, height: 12, color: Colors.white),
              ],
            ),
          ),
        ),
      );
}
