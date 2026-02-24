import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/routes/app_routes.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/services/navigation_service.dart';
import '../../../../core/utils/functions/show_removed_snack_bar.dart';
import '../../../../core/widgets/custom_button_widget.dart';
import '../../domain/entities/cart_item.dart';
import '../manager/cart_cubit.dart';
import 'cart_item_card.dart';
import 'cart_summary_section.dart';

class CartItemsListViewBuilder extends StatelessWidget {
  const CartItemsListViewBuilder({
    super.key,
    required this.items,

  });

  final List<CartItem> items;

  @override
  Widget build(BuildContext context) {
      final subtotal = items.fold<double>(
                    0, (s, it) => s + it.price * it.quantity);
                final shipping = items.isEmpty ? 0.0 : 3.5;
                final tax = subtotal * 0.05;
                final total = subtotal + shipping + tax;
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
                child: const Icon(Icons.delete_forever,
                    color: kTextDark),
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
                      return;
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
            total: total,
            button: CustomButton(
              buttonText: 'Proceed To checkout',
              onTap: () => NavigationService.navigateTo(
                  AppRoutes.checkout),
            ),
          );
        },
      ),
    );
  }
}
