import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_shop_app/config/routes/app_routes.dart';

import '../../../../core/services/navigation_service.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/custom_button_widget.dart';
import '../../../../core/widgets/custom_snackbar_widget.dart';
import '../../../cart/presentation/manager/cart_cubit.dart';
import '../../../cart/presentation/widgets/cart_summary_section.dart';
import '../../../cart/domain/entities/cart_item_entity.dart';
import '../../../orders/presentation/manager/order_cubit.dart';
import '../manager/payment_cubit/payment_cubit.dart';
import '../widgets/add_card_form.dart';

class AddCardScreen extends StatefulWidget {
  const AddCardScreen({super.key, required this.amount});
  final double amount;

  @override
  State<AddCardScreen> createState() => _AddCardScreenState();
}

class _AddCardScreenState extends State<AddCardScreen> {
  final _formKey = GlobalKey<AddCardFormState>();

  void _trySubmit(List<CartItemEntity> items) {
    final card = _formKey.currentState?.getCardIfValid();
    if (card == null) return;

    context.read<PaymentCubit>().tokenizeAndPay(
          card: card,
          amount: widget.amount,
          items: items,
        );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.white,
        appBar: const PreferredSize(
            preferredSize: Size.fromHeight(50),
            child: CustomAppBar(title: 'Add Card')),
        body: BlocListener<PaymentCubit, PaymentState>(
          listener: (context, state) {
            if (state is PaymentSuccess) {
              final tx = state.result;
              showCustomSnackBarWidget(
                  'Payment success ${tx.transactionId}', context);
              context.read<CartCubit>().clearCart();
              context.read<OrderCubit>().loadOrders();

              NavigationService.navigateAndReplace(AppRoutes.layout);
            } else if (state is PaymentFailureState) {
              showCustomSnackBarWidget(
                  'Payment failed: ${state.message}', context,
                  sanckBarType: SnackBarType.error);
            }
          },
          child: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Column(
                children: [
                  const SizedBox(height: 8),
                  AddCardForm(key: _formKey),
                  const SizedBox(height: 108),
                  BlocBuilder<CartCubit, CartState>(builder: (context, state) {
                    if (state.status == CartStatus.loaded) {
                      final items = state.items;
                      final subtotal =
                          items.fold<double>(0, (s, it) => s + it.totalPrice);
                      final shipping = items.isEmpty ? 0.0 : 3.5;

                      final total = subtotal + shipping;
                      return CartSummarySection(
                        subtotal: subtotal,
                        delivery: shipping,
                        total: total,
                        button: BlocBuilder<PaymentCubit, PaymentState>(
                          builder: (context, state) {
                            final isLoading = state is PaymentLoading;
                            return CustomButton(
                                buttonText: 'Make Payment',
                                onPressed:
                                    isLoading ? null : () => _trySubmit(items),
                                radius: 12,
                                isLoading: isLoading);
                          },
                        ),
                      );
                    }
                    return const SizedBox.shrink();
                  })
                ],
              ),
            ),
          ),
        ),
      );
}
