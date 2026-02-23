import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../manager/cart_cubit.dart';
import '../widgets/cart_items_list_view_builder.dart';
import '../widgets/empty_cart_state.dart';
import '../widgets/cart_item_shimmer.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.white,
        appBar: const PreferredSize(
            preferredSize: Size.fromHeight(50),
            child: CustomAppBar(title: 'Shopping Cart')),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            child: BlocBuilder<CartCubit, CartState>(
              builder: (context, state) {
                if (state is CartInitial || state is CartLoading) {
                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    itemBuilder: (_, __) => const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      child: SizedBox(height: 90, child: CartItemShimmer()),
                    ),
                    itemCount: 5,
                  );
                } else if (state is CartError) {
                  return Center(child: Text(state.message));
                } else if (state is CartEmpty) {
                  return const EmptyCartState();
                } else if (state is CartLoaded) {
                  final items = state.items;

                  return Column(
                    children: [
                      const SizedBox(height: 10),
                      CartItemsListViewBuilder(items: items),
                    ],
                  );
                } 

                return  const SizedBox.shrink();
              },
            ),
          ),
        ),
      );
}
