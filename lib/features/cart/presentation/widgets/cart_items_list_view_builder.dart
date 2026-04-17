import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/routes/app_routes.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/services/navigation_service.dart';
import '../../../../core/utils/functions/show_removed_snack_bar.dart';
import '../../../../core/widgets/custom_button_widget.dart';
import '../../domain/entities/cart_item_entity.dart';
import '../manager/cart_cubit.dart';
import 'cart_item_card.dart';
import 'cart_summary_section.dart';
import 'empty_cart_state.dart';

class CartItemsListViewBuilder extends StatelessWidget {
  const CartItemsListViewBuilder({
    super.key,
    required this.items,
    required this.totalPrice,
  });

  final List<CartItemEntity> items;
  final num totalPrice;

  @override
  Widget build(BuildContext context) {
    final shipping = items.isEmpty ? 0.0 : 3.5;
    // final tax = subtotal * 0.05;
    // final total = subtotal + shipping + tax;
    final total = totalPrice + shipping;
    return Expanded(
      child: ListView.builder(
        itemCount: items.length + 1,
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
                child: const Icon(Icons.delete_forever, color: kTextDark),
              ),
              onDismissed: (_) {
                context.read<CartCubit>().removeFromCart(item.id);
                showRemovedSnackBar(context, item);
              },
              child: CartItemCard(
                  item: item,
                  onIncrement: () => context
                      .read<CartCubit>()
                      .updateQuantity(item.id, item.quantity + 1),
                  onDecrement: () {
                    final newQ = item.quantity - 1;
                    if (newQ <= 0) {
                      return;
                    } else {
                      context
                          .read<CartCubit>()
                          .updateQuantity(item.id, newQ);
                    }
                  },
                  onRemove: () {
                    context.read<CartCubit>().removeFromCart(item.id);
                    showRemovedSnackBar(context, item);
                  }),
            );
          }
          if (items.isNotEmpty) {
            return CartSummarySection(
              subtotal: totalPrice.toDouble(),
              delivery: shipping,
              total: total,
              button: CustomButton(
                buttonText: 'Proceed To checkout',
                onPressed: () =>
                    NavigationService.navigateTo(AppRoutes.checkout),
              ),
            );
          } else {
            return const Padding(
              padding: EdgeInsets.symmetric(vertical: 160),
              child: EmptyCartState(),
            );
          }
        },
      ),
    );
  }
}
