import 'package:flutter/material.dart';

import 'filters_card_widget.dart';

class FilterShimmerListViewWidget extends StatelessWidget {
  const FilterShimmerListViewWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: SizedBox(
          height: 40,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: 6,
            separatorBuilder: (_, __) => const SizedBox(width: 8),
            itemBuilder: (context, index) => const Padding(
              padding: EdgeInsets.symmetric(horizontal: 6),
              child: FiltersCardWidget(
                  filterName: 'Filter Name', active: false, isLoading: true),
            ),
          ),
        ),
      );
}
