import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/custom_app_bar_widget.dart';
import '../../../../core/widgets/filter_list_view_widget.dart';
import '../../../../core/widgets/filter_shimmer_list_view_widget.dart';
import '../manger/products_cubit.dart';
import '../manger/products_state.dart';
import '../../domain/entities/product.dart';
import '../widgets/product_grid_view.dart';
import '../widgets/product_shimmer_grid_view.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: const Color(0xFFFFFFFF),
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: CustomAppBarWidget(
            label: 'Big & Small Fishes',
            labelSize: 16,
            labelColor: Color(0xFF1E222B),
            backgroundColor: Colors.white,
            automaticallyImplyLeading: true,
          ),
        ),
        body: BlocBuilder<ProductsCubit, ProductsState>(
            builder: (context, state) {
          final cubit = context.read<ProductsCubit>();
          if (state is ProductsInitial) {
            cubit.load();
          }
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

          final List<Product> products =
              state is ProductsLoaded ? state.products : <Product>[];
          final filters = cubit.filters;

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
        }),
      );
}
