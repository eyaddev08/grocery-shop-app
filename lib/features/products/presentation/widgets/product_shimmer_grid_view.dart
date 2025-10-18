import 'package:flutter/material.dart';

import 'product_card.dart';

class ProductShimmerGridView extends StatelessWidget {
  const ProductShimmerGridView({
    super.key,
  });

  @override
  Widget build(BuildContext context) => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
          childAspectRatio: 0.7,
        ),
        itemCount: 6,
        itemBuilder: (context, index) =>
            const ProductCard(product: null, isLoading: true),
      ),
    );
}

