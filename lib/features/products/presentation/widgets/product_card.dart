import 'package:flutter/material.dart';

import 'package:grocery_shop_app/core/constants/app_colors.dart';
import '../../../../core/utils/styles.dart';
import '../../../../core/widgets/add_card_widget.dart';
import '../../../../core/widgets/custom_image_widget.dart';
import '../../../product_details/presentation/screens/product_details_screen.dart';
import '../../domain/entities/product_entity.dart';
import 'product_shimmer_card.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this.product, this.isLoading = false});

  final ProductEntity? product;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final p = product;

    return AnimatedSwitcher(
        duration: const Duration(seconds: 5),
        switchInCurve: Curves.easeIn,
        switchOutCurve: Curves.easeOut,
        transitionBuilder: (child, animation) =>
            FadeTransition(opacity: animation, child: child),
        child: isLoading
            ? const ProductShimmerCard()
            : GestureDetector(
                onTap: () => Navigator.push<void>(
                    context,
                    MaterialPageRoute<void>(
                      builder: (builder) =>
                          ProductDetailsScreen(productId: p.id, initialProduct: p),
                    )),
                child: SizedBox(
                  height: 194,
                  child: Container(
                    width: 160,
                    height: 194,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF7F8FA),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Container(
                            width: 98,
                            height: 98,
                            decoration:
                                const BoxDecoration(shape: BoxShape.circle),
                            child: Center(
                              child: CustomImageWidget(image: p?.thumbnail ?? ''),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            AddCardWidget(
                                id: p!.id,
                                title: p.name,
                                price: p.price,
                                regularPrice: p.originalPrice,
                                image: p.thumbnail!,
                                sizeContainer: 26,
                                sizeIcon: 14),
                          ],
                        ),
                        Text('\$${p.price.toStringAsFixed(2)}',
                            style: textBold),
                        const SizedBox(height: 4),
                        Text(
                          p.name,
                          style: textBold.copyWith(
                            color: kMuted,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ));
  }
}
