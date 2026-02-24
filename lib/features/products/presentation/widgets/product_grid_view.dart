import 'package:flutter/material.dart';

import '../../domain/entities/product_entity.dart';
import 'product_card.dart';

class ProductGridView extends StatelessWidget {
  const ProductGridView({
    super.key,
    required this.products,
  });

  final List<ProductEntity> products;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 20,
            crossAxisSpacing: 20,
            childAspectRatio: 0.8,
          ),
          itemCount: products.length,
          itemBuilder: (context, index) =>
              ProductCard(product: products[index]),
        ),
      );
}
