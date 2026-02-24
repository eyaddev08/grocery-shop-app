
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/widgets/custom_app_bar_widget.dart';
import '../../../../core/widgets/filter_list_view_widget.dart';
import '../../../../core/widgets/filter_shimmer_list_view_widget.dart';
import '../manger/products_cubit.dart';
import '../manger/products_state.dart';
import '../../domain/entities/product_entity.dart';
import '../widgets/no_products_widget.dart';
import '../widgets/product_grid_view.dart';
import '../widgets/product_shimmer_grid_view.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key, this.categoryTitle});
  final String? categoryTitle;

  @override
  Widget build(BuildContext context) => Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: CustomAppBarWidget(
          label: categoryTitle ?? 'Products',
          labelSize: 16,
          labelColor: const Color(0xFF1E222B),
          backgroundColor: Colors.white,
          isBackButtonExist: true,
        ),
      ),
      body: BlocBuilder<ProductsCubit, ProductsState>(
        builder: (context, state) {
          final cubit = context.read<ProductsCubit>();

          if (state is ProductsLoading) {
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

          if (state is ProductsError) {
            return Center(child: Text(state.message));
          }

          if (state is ProductsEmpty) {
            return NoProductsWidget(
              message: state.message ?? 'No products in this category',
              onShowAll: cubit.loadProducts,
            );
          }

          final List<ProductEntity> products =
              state is ProductsLoaded ? state.products : <ProductEntity>[];
          final filters = cubit.filters;

          // additional check: if ProductsLoaded with empty list, show empty widget (safe-guard)
          if (products.isEmpty) {
            return NoProductsWidget(
              message: 'No products in this category',
              onShowAll: cubit.loadProducts,
            );
          }

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                FilterListViewWidget(filters: filters, cubit: cubit),
                const SizedBox(height: 15),
                ProductGridView(products: products),
              ],
            ),
          );
        },
      ),
    );
}
