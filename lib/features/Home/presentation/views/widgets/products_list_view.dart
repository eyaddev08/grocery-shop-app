import 'package:flutter/material.dart';

import '../../../../../core/constants/app_colors.dart';
import 'product_card.dart';

class ProductListView extends StatelessWidget {
  const ProductListView({
    super.key,
    required this.scale,
  });

  final products = const [
    {
      'price': r'$325',
      'title': 'Orange Package 1 | 1 bundle',
      'badge': kPrimaryBlue
    },
    {
      'price': r'$89',
      'title': 'Green Tea Package 2 | 1 bundle',
      'badge': kYellow
    },
    {'price': r'$120', 'title': 'Apple Pack | 3 kg', 'badge': kPrimaryBlue},
    {'price': r'$45', 'title': 'Black Tea | 1 pack', 'badge': kYellow},
  ];
  final double scale;

  @override
  Widget build(BuildContext context) => GridView.builder(
      itemCount: products.length,
      padding:
          EdgeInsets.symmetric(horizontal: 16 * scale, vertical: 12 * scale),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 0.78),
      itemBuilder: (context, idx) {
        final item = products[idx];
        final Color badge = item['badge'] as Color;
        return ProductCard(
            price: item['price'] as String,
            title: item['title'] as String,
            badgeColor: badge);
      });
}
