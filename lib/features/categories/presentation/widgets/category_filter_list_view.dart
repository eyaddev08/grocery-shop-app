import 'package:flutter/material.dart';

import '../../../../core/widgets/filters_card_widget.dart';
import '../manager/categories_cubit.dart';

class CategoryFilterListView extends StatelessWidget {
  const CategoryFilterListView({
    super.key,
    required this.filters,
    required this.cubit,
  });

  final List<String> filters;
  final CategoriesCubit cubit;

  @override
  Widget build(BuildContext context) => SizedBox(
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
                    await cubit.filterCategory(index);
                  }),
            );
          },
        ),
      );
}
