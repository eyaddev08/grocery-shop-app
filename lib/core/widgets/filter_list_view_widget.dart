import 'package:flutter/material.dart';

import '../../features/products/presentation/manger/products_cubit.dart';
import 'filters_card_widget.dart';

class FilterListViewWidget extends StatelessWidget {
  const FilterListViewWidget({
    super.key,
    required this.filters,
    required this.cubit,
  });

  final List<String> filters;
  final ProductsCubit cubit;

  @override
  Widget build(BuildContext context) => Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: SizedBox(
        height: 40,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: filters.length,
          itemBuilder: (context, index) {
            final label = filters[index];
            final isSelected = cubit.filterIndex == index;
    
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: FiltersCardWidget(
                  filterName: label,
                  active: isSelected,
                  onTap: () async {
                    await cubit.filterProducts(index);
                  }),
            );
          },
        ),
      ),
    );
}
