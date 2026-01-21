 import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../features/search/presentation/manager/search_cubit.dart';
import '../../../features/search/presentation/manager/search_state.dart';
import '../../../features/search/presentation/widgets/sort_bottom_sheet.dart';

void showSortModal(BuildContext context, SearchLoaded state) {
    // Get current price range filters or defaults
    final filters = context.read<SearchCubit>().selectedFilters;
    final minPrice = state.result.facets.minPrice ?? 0.0;
    final maxPrice = state.result.facets.maxPrice ?? 1000.0;

    final double start =
        double.tryParse(filters['price_min']?.toString() ?? '') ?? minPrice;
    final double end =
        double.tryParse(filters['price_max']?.toString() ?? '') ?? maxPrice;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => SortBottomSheet(
        currentSort: context.read<SearchCubit>().currentSort,
        currentPriceRange: RangeValues(start, end),
        maxPriceLimits: RangeValues(minPrice, maxPrice),
        onApply: (sort, priceRange) {
          final cubit = context.read<SearchCubit>();

          // Update Sort
          cubit.updateSort(sort);

          // Update Price Filters
          final newFilters = Map<String, dynamic>.from(cubit.selectedFilters);
          newFilters['price_min'] = priceRange.start;
          newFilters['price_max'] = priceRange.end;
          cubit.updateFilters(newFilters);
        },
      ),
    );
  }
