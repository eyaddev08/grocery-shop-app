import 'package:flutter/material.dart';

import 'deal_product_card.dart';

class DealsProductShimmerGridView extends StatelessWidget {
  const DealsProductShimmerGridView({
    super.key,
  });

  @override
  Widget build(BuildContext context) => GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 0.88),
        itemCount: 6,
        itemBuilder: (context, index) =>
            const DealProductCard(product: null, isLoading: true),
      );
}
