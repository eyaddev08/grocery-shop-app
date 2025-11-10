import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:grocery_shop_app/core/constants/app_colors.dart';

class ShimmerProductDetail extends StatelessWidget {
  const ShimmerProductDetail({
    super.key,
    required this.designW,
    this.similarCount = 4,
  });
  final double designW;
  final int similarCount;

  // helper for line placeholder
  Widget _line(double width, {double height = 12, BorderRadius? radius}) =>
      Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: radius ?? BorderRadius.circular(6),
        ),
      );

  // small rounded rectangle
  Widget _pill(double w, double h) => Container(
        width: w,
        height: h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(999),
        ),
      );

  @override
  Widget build(BuildContext context) => Shimmer.fromColors(
        baseColor: kBaseColor,
        highlightColor: kHighlightColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // big circular image placeholder
            Center(
              child: Column(
                children: [
                  Container(
                    width: 241,
                    height: 241,
                    decoration: BoxDecoration(
                      color: kBaseColor,
                      borderRadius: BorderRadius.circular(180),
                    ),
                  ),

                  const SizedBox(height: 34),

                  // indicators
                  Transform.translate(
                    offset: const Offset(0, -28),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                            width: 24,
                            height: 4,
                            decoration: BoxDecoration(
                                color: kBaseColor,
                                borderRadius: BorderRadius.circular(10))),
                        const SizedBox(width: 8),
                        Container(
                            width: 18,
                            height: 6,
                            decoration: BoxDecoration(
                                color: kBaseColor,
                                borderRadius: BorderRadius.circular(10))),
                        const SizedBox(width: 8),
                        Container(
                            width: 18,
                            height: 4,
                            decoration: BoxDecoration(
                                color: kBaseColor,
                                borderRadius: BorderRadius.circular(10))),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 8),

            // title
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 26),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 178,
                    child: Container(
                      height: 22,
                      decoration: BoxDecoration(
                          color: kBaseColor,
                          borderRadius: BorderRadius.circular(6)),
                    ),
                  ),
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                        color: kBaseColor, shape: BoxShape.circle),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // price row (price + off pill + reg price)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 26),
              child: Row(
                children: [
                  // price
                  Container(
                      width: 90,
                      height: 18,
                      decoration: BoxDecoration(
                          color: kBaseColor,
                          borderRadius: BorderRadius.circular(6))),
                  const SizedBox(width: 10),
                  // off pill
                  Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                          color: kBaseColor,
                          borderRadius: BorderRadius.circular(70)),
                      width: 86,
                      height: 24),
                  const Spacer(),
                  // reg price
                  Container(
                      width: 110,
                      height: 14,
                      decoration: BoxDecoration(
                          color: kBaseColor,
                          borderRadius: BorderRadius.circular(6))),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // rating row (stars placeholders + reviews)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 26),
              child: Row(
                children: [
                  Row(
                    children: List.generate(
                        5,
                        (i) => const Padding(
                              padding: EdgeInsets.only(right: 4),
                              child: Icon(Icons.star,
                                  color: kAccentYellow, size: 15),
                            )),
                  ),
                  const SizedBox(width: 8),
                  Container(
                      width: 80,
                      height: 14,
                      decoration: BoxDecoration(
                          color: kBaseColor,
                          borderRadius: BorderRadius.circular(6))),
                ],
              ),
            ),

            const SizedBox(height: 18),

            // action buttons placeholders
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 26),
              child: Row(
                children: [
                  Container(
                    width: 143,
                    height: 56,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: kBaseColor),
                    ),
                    child: Center(
                        child: Container(
                            width: 80, height: 16, color: kBaseColor)),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Container(
                      height: 56,
                      decoration: BoxDecoration(
                          color: kBaseColor,
                          borderRadius: BorderRadius.circular(20)),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // details title + paragraph lines
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        width: 90,
                        height: 16,
                        decoration: BoxDecoration(
                            color: kBaseColor,
                            borderRadius: BorderRadius.circular(6))),
                    const SizedBox(height: 8),
                    Container(
                        width: 327,
                        height: 12,
                        decoration: BoxDecoration(
                            color: kBaseColor,
                            borderRadius: BorderRadius.circular(6))),
                    const SizedBox(height: 6),
                    Container(
                        width: 280,
                        height: 12,
                        decoration: BoxDecoration(
                            color: kBaseColor,
                            borderRadius: BorderRadius.circular(6))),
                  ]),
            ),

            const SizedBox(height: 18),

            // Nutritional facts expansion placeholder (title + line)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        width: 140,
                        height: 16,
                        decoration: BoxDecoration(
                            color: kBaseColor,
                            borderRadius: BorderRadius.circular(6))),
                    const SizedBox(height: 8),
                    Container(
                        width: 327,
                        height: 12,
                        decoration: BoxDecoration(
                            color: kBaseColor,
                            borderRadius: BorderRadius.circular(6))),
                  ]),
            ),

            const SizedBox(height: 12),
            // divider mimic
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Container(height: 1, color: Colors.white),
            ),
            const SizedBox(height: 6),

            // Reviews title + placeholders
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        width: 90,
                        height: 16,
                        decoration: BoxDecoration(
                            color: kBaseColor,
                            borderRadius: BorderRadius.circular(6))),
                    const SizedBox(height: 10),
                    Container(
                        width: 327,
                        height: 12,
                        decoration: BoxDecoration(
                            color: kBaseColor,
                            borderRadius: BorderRadius.circular(6))),
                    const SizedBox(height: 8),
                    Container(
                        width: 220,
                        height: 12,
                        decoration: BoxDecoration(
                            color: kBaseColor,
                            borderRadius: BorderRadius.circular(6))),
                  ]),
            ),

            const SizedBox(height: 12),

            // Similar section title
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Container(
                  width: 80,
                  height: 18,
                  decoration: BoxDecoration(
                      color: kBaseColor,
                      borderRadius: BorderRadius.circular(6))),
            ),
            const SizedBox(height: 12),
          ],
        ),
      );
}
