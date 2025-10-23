import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/functions/show_removed_snack_bar.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../manager/cart_cubit.dart';
import '../widgets/cart_item_card.dart';
import '../widgets/cart_summary_section.dart';
import '../widgets/empty_cart_state.dart';
import '../widgets/cart_item_shimmer.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final cubit = context.read<CartCubit>();
      if (cubit.state is! CartLoaded && cubit.state is! CartLoading) {
        cubit.load();
      }
    });

    return Scaffold(
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
                return ListView.separated(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  itemBuilder: (_, __) => const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: SizedBox(height: 90, child: CartItemShimmer()),
                  ),
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemCount: 5,
                );
              }

              if (state is CartError) {
                return Center(child: Text(state.message));
              }

              if (state is CartLoaded) {
                final items = state.items;
                if (items.isEmpty) return const EmptyCartState();

                final subtotal = items.fold<double>(
                    0, (s, it) => s + it.price * it.quantity);
                final shipping = items.isEmpty ? 0.0 : 3.5;
                final tax = subtotal * 0.05;
                final total = subtotal + shipping + tax;

                return Column(
                  children: [
                    const SizedBox(height: 10),
                    Expanded(
                      child: ListView.separated(
                        itemCount: items.length + 1,
                        separatorBuilder: (_, __) => const SizedBox(height: 20),
                        itemBuilder: (context, index) {
                          if (index < items.length) {
                            final item = items[index];
                            return Dismissible(
                              key: ValueKey(item.id),
                              direction: DismissDirection.endToStart,
                              background: Container(
                                alignment: Alignment.centerRight,
                                padding: const EdgeInsets.only(right: 20),
                                decoration: BoxDecoration(
                                  color: Colors.red.shade700,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Icon(Icons.delete_forever,
                                    color: textDark),
                              ),
                              onDismissed: (_) {
                                context.read<CartCubit>().removeItem(item.id);
                                showRemovedSnackBar(context, item);
                              },
                              child: CartItemCard(
                                  item: item,
                                  onIncrement: () => context
                                      .read<CartCubit>()
                                      .updateQuantity(
                                          item.id, item.quantity + 1),
                                  onDecrement: () {
                                    final newQ = item.quantity - 1;
                                    if (newQ <= 0) {
                                      context
                                          .read<CartCubit>()
                                          .removeItem(item.id);
                                    } else {
                                      context
                                          .read<CartCubit>()
                                          .updateQuantity(item.id, newQ);
                                    }
                                  },
                                  onRemove: () {
                                    context
                                        .read<CartCubit>()
                                        .removeItem(item.id);
                                    showRemovedSnackBar(context, item);
                                  }),
                            );
                          }
                          return CartSummarySection(
                              subtotal: subtotal,
                              delivery: shipping,
                              total: total);
                        },
                      ),
                    ),
                  ],
                );
              }

              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }
}
