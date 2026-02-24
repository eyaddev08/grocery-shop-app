import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/custom_app_bar_widget.dart';
import '../../../../core/widgets/filter_shimmer_list_view_widget.dart';
import '../manager/categories_cubit.dart';
import '../manager/categories_state.dart';
import '../widgets/category_filter_list_view.dart';
import '../widgets/category_list_view.dart';
import '../widgets/category_shimmer_list_view.dart';
import '../widgets/title_header.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: CustomAppBarWidget(showSearchIcon: false),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TitleHeader(),
            const SizedBox(height: 16),
            BlocBuilder<CategoriesCubit, CategoriesState>(
              builder: (context, state) {
                final cubit = context.read<CategoriesCubit>();

                if (state is CategoriesLoading) {
                  return const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FilterShimmerListViewWidget(),
                      CategoryShimmerListView()
                    ],
                  );
                }
                if (state is CategoriesError) {
                  return Center(child: Text(state.message));
                }
                if (state is CategoriesLoaded) {
                  final category = state.categories;
                  final filters = cubit.filters;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CategoryFilterListView(filters: filters, cubit: cubit),
                      CategoryListView(category: category)
                    ],
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );
}
