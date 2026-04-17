// import 'package:flutter/material.dart';

// import '../../features/products/presentation/manager/product_cubit/product_cubit.dart';
// import 'filters_card_widget.dart';

// class FilterListViewWidget extends StatelessWidget {
//   const FilterListViewWidget({
//     super.key,
//     required this.filters,
//     required this.cubit,
//   });

//   final List<String> filters;
//   final ProductCubit cubit;

//   @override
//   Widget build(BuildContext context) => Padding(
//         padding: const EdgeInsets.symmetric(vertical: 6),
//         child: SizedBox(
//           height: 40,
//           child: ListView.builder(
//             scrollDirection: Axis.horizontal,
//             itemCount: filters.length,
//             itemBuilder: (context, index) {
//               final label = filters[index];
//               final isSelected = cubit.filterIndex == index;

//               return Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 6),
//                 child: FiltersCardWidget(
//                     filterName: label,
//                     active: isSelected,
//                     onTap: () async {
//                       await cubit.filterProducts(index);
//                     }),
//               );
//             },
//           ),
//         ),
//       );
// }


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/products/presentation/manager/product_cubit/product_cubit.dart';
import '../../features/products/presentation/manager/product_cubit/product_state.dart';
import 'filters_card_widget.dart'; 

class FilterListViewWidget extends StatelessWidget {
  const FilterListViewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCubit, ProductState>(
      buildWhen: (previous, current) =>
          previous.selectedFilterIndex != current.selectedFilterIndex ||
          previous.filters != current.filters,
      builder: (context, state) {
        final filters = state.filters;
        final selectedIndex = state.selectedFilterIndex;

        if (filters.isEmpty) return const SizedBox.shrink();

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: SizedBox(
            height: 40, // ارتفاع متناسق للأزرار
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              // إضافة مسافة بادئة لكي لا يلتصق زر All بحافة الشاشة
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: filters.length,
              separatorBuilder: (context, index) => const SizedBox(width: 8),
              itemBuilder: (context, index) {
                final label = filters[index];
                final isSelected = selectedIndex == index;

                return FiltersCardWidget(
                  filterName: label,
                  active: isSelected, // هذا سيفعل اللون الأصفر في الويدجت الخاص بك
                  onTap: () {
                    // استدعاء الفلترة السريعة
                    context.read<ProductCubit>().filterProducts(index);
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }
}