import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../core/constants/app_colors.dart';
import 'delivery_man_card_shimmer.dart';
import 'info_item_shimmer.dart';

class TrackOrderShimmer extends StatelessWidget {
  const TrackOrderShimmer({super.key});

  @override
  Widget build(BuildContext context) => Shimmer.fromColors(
        baseColor: kBaseColor,
        highlightColor: kHighlightColor,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                    child: Container(
                      width: 335,
                      height: 436,
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        color: Colors.white30,
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),

                  // Delivery man card shimmer
                  const Positioned(top: 390, child: DeliveryManCardShimmer()),
                ],
              ),

              const SizedBox(height: 80),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    InfoItemShimmer(),
                    SizedBox(height: 20),
                    InfoItemShimmer(),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              // Bottom sheet shimmer
              Container(
                width: double.infinity,
                height: 105,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Container(
                      height: 14,
                      width: 120,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Row(
                      children: [
                        Container(
                          height: 14,
                          width: 20,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        const SizedBox(width: 4),
                        Container(
                          height: 14,
                          width: 80,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(4),
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
      );
}
