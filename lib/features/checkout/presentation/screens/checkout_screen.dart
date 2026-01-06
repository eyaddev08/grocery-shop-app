import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_shop_app/config/routes/app_routes.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/services/navigation_service.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/custom_button_widget.dart';
import '../../../../core/widgets/custom_snackbar_widget.dart';
import '../../../../core/widgets/delet_address_show_dialog_widget.dart';
import '../../../cart/presentation/manager/cart_cubit.dart';
import '../manager/checkout_cubit.dart';
import '../manager/checkout_state.dart';
import '../widgets/add_new_address_card.dart';
import '../widgets/address_card.dart';
import 'edit_address_screen.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: BlocBuilder<CartCubit, CartState>(
            builder: (context, state) {
              int count = 0;
              if (state is CartLoaded) count = state.items.length;

              return CustomAppBar(title: 'Shopping Cart ($count)');
            },
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                const SizedBox(height: 24),
                const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Delivery Address',
                      style: TextStyle(
                          color: kTextDark,
                          fontSize: 16,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                          height: 1.50),
                    )),
                const SizedBox(height: 12),
                Expanded(
                  child: BlocBuilder<CheckoutCubit, CheckoutState>(
                    builder: (context, state) {
                      if (state is CheckoutLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is CheckoutEmpty) {
                        return Center(
                          child: AddNewAddressCard(onTap: () async {
                            await NavigationService.navigateTo(
                                AppRoutes.addAddress);
                          }),
                        );
                      } else if (state is CheckoutLoaded) {
                        final list = state.addresses;
                        return SingleChildScrollView(
                          child: Column(
                            children: [
                              ...list.map((a) => AddressCard(
                                    address: a,
                                    onSelect: () => context
                                        .read<CheckoutCubit>()
                                        .chooseDefault(a.id),
                                    onEdit: () async {
                                      await Navigator.of(context).push(
                                          MaterialPageRoute<void>(
                                              builder: (_) =>
                                                  BlocProvider.value(
                                                    value: context
                                                        .read<CheckoutCubit>(),
                                                    child: EditAddressScreen(
                                                        address: a),
                                                  )));
                                      showCustomSnackBarWidget(
                                          'Edit Address', context);
                                      await context
                                          .read<CheckoutCubit>()
                                          .loadAddresses();
                                    },
                                    onDelete: () async {
                                      final confirm =
                                          await showGeneralDialog<bool>(
                                        context: context,
                                        barrierDismissible: true,
                                        barrierLabel: 'Dismiss',
                                        pageBuilder: (ctx, anim1, anim2) =>
                                            const Center(
                                                child:
                                                    DeletFromAddressShowDialog()),
                                      );

                                      if (confirm == true) {
                                        await context
                                            .read<CheckoutCubit>()
                                            .removeAddress(a.id);

                                        showCustomSnackBarWidget(
                                            'Address deleted', context);
                                      }
                                    },
                                  )),
                              const SizedBox(height: 12),
                              AddNewAddressCard(onTap: () async {
                                await NavigationService.navigateTo(
                                    AppRoutes.addAddress);
                              }),
                              const SizedBox(height: 270),
                              CustomButton(
                                onTap: () async {
                                  await NavigationService.navigateTo(
                                      AppRoutes.addCard);
                                },
                                buttonText: 'Add Card',
                                radius: 20,
                              ),
                            ],
                          ),
                        );
                      } else if (state is CheckoutError) {
                        return Center(child: Text('Error: ${state.message}'));
                      } else {
                        return const SizedBox.shrink();
                      }
                    },
                  ),
                ),
                const SizedBox(height: 12),
              ],
            ),
          ),
        ),
      );
}
