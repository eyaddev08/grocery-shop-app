import 'package:flutter/material.dart';

import '../../../products/domain/entities/product_entity.dart';
import 'deal_product_card.dart';

class DealsProductsGridView extends StatelessWidget {
  const DealsProductsGridView({
    super.key,
    required this.scale,
    required this.product,
  });
  final List<ProductEntity> product;
  final double scale;

  @override
  Widget build(BuildContext context) => GridView.builder(
      itemCount: product.length,
      padding:
          EdgeInsets.symmetric(horizontal: 16 * scale, vertical: 12 * scale),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 0.88),
      itemBuilder: (context, idx) => DealProductCard(product: product[idx]));
}
