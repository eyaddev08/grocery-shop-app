import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/styles.dart';
import '../../../../core/widgets/custom_app_bar_widget.dart';
import '../../../../core/widgets/filter_list_view_widget.dart';
import '../../../../core/widgets/filter_shimmer_list_view_widget.dart';
import '../../../../core/widgets/no_items_widget.dart';
import '../manager/product_cubit/product_cubit.dart';
import '../manager/product_cubit/product_state.dart';
import '../widgets/product_grid_view.dart';
import '../widgets/product_shimmer_grid_view.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({
    super.key,
    required this.title,
    required this.source,
    this.categoryId,
  });

  final String title;
  final ProductSource source;
  final int? categoryId;

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ProductCubit>().fetchProductsBySource(
          source: widget.source,
          categoryId: widget.categoryId,
        );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: const Color(0xFFFFFFFF),
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: CustomAppBarWidget(
            label: widget.title,
            labelSize: 16,
            labelColor: const Color(0xFF1E222B),
            backgroundColor: Colors.white,
            isBackButtonExist: true,
          ),
        ),
        body: BlocBuilder<ProductCubit, ProductState>(
          builder: (context, state) {
            if (state.status == ProductStatus.loading ||
                state.status == ProductStatus.initial) {
              return const SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    FilterShimmerListViewWidget(),
                    SizedBox(height: 15),
                    ProductShimmerGridView(),
                  ],
                ),
              );
            }

            if (state.status == ProductStatus.error) {
              return Center(
                child: Text(
                  state.errorMessage,
                  style: textBold,
                ),
              );
            }

            if (state.originalProducts.isEmpty) {
              return NoItemsWidget(
                message: 'No products found in this section.',
                onShowAll: () => context.read<ProductCubit>().loadProducts(),
              );
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                const FilterListViewWidget(),
                const SizedBox(height: 15),
                Expanded(
                  child: state.allProducts.isEmpty
                      ? Center(
                          child: Text(
                          'No items match this filter.',
                          style: textBold.copyWith(
                              fontSize: 16, color: Colors.grey[700]),
                        ))
                      : SingleChildScrollView(
                          child: ProductGridView(products: state.allProducts),
                        ),
                ),
              ],
            );
          },
        ),
      );
}
