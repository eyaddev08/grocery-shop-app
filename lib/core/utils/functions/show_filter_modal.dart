  import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../features/search/presentation/manager/search_cubit.dart';
import '../../../features/search/presentation/manager/search_state.dart';
import '../../../features/search/presentation/widgets/filter_bottom_sheet.dart';

void showFilterModal(BuildContext context, SearchLoaded state) {
    showModalBottomSheet<BottomSheet>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => FilterBottomSheet(
        facets: state.result.facets,
        currentFilters: context.read<SearchCubit>().selectedFilters,
        onApply: (filters) {
          context.read<SearchCubit>().updateFilters(filters);
        },
      ),
    );
  }
