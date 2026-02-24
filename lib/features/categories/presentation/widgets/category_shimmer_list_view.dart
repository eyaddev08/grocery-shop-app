import 'package:flutter/material.dart';

import 'category_shimmer_card.dart';

class CategoryShimmerListView extends StatelessWidget {
  const CategoryShimmerListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) => ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: 4,
        padding: const EdgeInsets.all(18),
        itemBuilder: (context, index) => const CategoryShimmerCard(),
      );
}
