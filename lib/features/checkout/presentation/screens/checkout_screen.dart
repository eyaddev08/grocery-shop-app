import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_shop_app/config/routes/app_routes.dart';
import 'package:grocery_shop_app/core/utils/styles.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/helpers/create_slide_fade_route.dart';
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
import '../widgets/address_tile_shimmer.dart';
import 'address_form_screen.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    int count = 0;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: BlocBuilder<CartCubit, CartState>(
          builder: (context, cartState) {
            if (cartState.status == CartStatus.loaded) count = cartState.items.length;

            final checkoutState = context.watch<CheckoutCubit>().state;
            final bool showAddInAppBar = checkoutState is CheckoutLoaded &&
                checkoutState.addresses.length > 3;

            return CustomAppBar(
              title: 'Shopping Cart ($count)',
              trailing: showAddInAppBar
                  ? TextButton(
                      onPressed: () async {
                        await NavigationService.navigateTo(
                          AppRoutes.addAddress,
                        );
                      },
                      child: Text(
                        'Add',
                        style: textBold.copyWith(
                          color: kPrimaryBlue,
                        ),
                      ),
                    )
                  : null,
            );
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
                      return ListView.separated(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        itemCount: 3,
                        separatorBuilder: (_, __) => const SizedBox(height: 12),
                        itemBuilder: (_, __) => const AddressTileShimmer(),
                      );
                    } else if (state is CheckoutEmpty) {
                      return Center(
                        child: AddNewAddressCard(onTap: () async {
                          await NavigationService.navigateTo(
                              AppRoutes.addAddress);
                        }),
                      );
                    } else if (state is CheckoutLoaded) {
                      final address = state.addresses;

                      return CustomScrollView(shrinkWrap: true, slivers: [
                        SliverToBoxAdapter(
                          child: Column(
                            children: [
                              ...address.map((a) => AddressCard(
                                    address: a,
                                    onSelect: () => context
                                        .read<CheckoutCubit>()
                                        .chooseDefault(a.id),
                                    onEdit: () async {
                                      await Navigator.of(context).push(
                                          createSlideFadeRoute(
                                              BlocProvider.value(
                                        value: context.read<CheckoutCubit>(),
                                        child: AddressFormScreen(address: a),
                                      )));
                                      await context
                                          .read<CheckoutCubit>()
                                          .loadAddresses();
                                    },
                                    onDelete: () async {
                                      final confirm = await showGeneralDialog<
                                              bool>(
                                          context: context,
                                          barrierDismissible: true,
                                          barrierLabel: 'Dismiss',
                                          pageBuilder: (ctx, anim1, anim2) =>
                                              const Center(
                                                  child:
                                                      DeletFromAddressShowDialog()));

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
                              if (address.length <= 3)
                                AddNewAddressCard(onTap: () async {
                                  await NavigationService.navigateTo(
                                    AppRoutes.addAddress,
                                  );
                                }),
                              const SizedBox(height: 24),
                            ],
                          ),
                        ),
                      ]);
                    } else if (state is CheckoutError) {
                      return Center(child: Text('Error: ${state.message}'));
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
      bottomNavigationBar: count >= 0
          ? BlocBuilder<CheckoutCubit, CheckoutState>(
              builder: (context, state) {
                final hasAddresses =
                    state is CheckoutLoaded && state.addresses.isNotEmpty;

                if (!hasAddresses) return const SizedBox.shrink();

                return SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: CustomButton(
                      onPressed: () async {
                        await NavigationService.navigateTo(AppRoutes.addCard,);
                      },
                      buttonText: 'Add Card',
                      radius: 20,
                    ),
                  ),
                );
              },
            )
          : const SizedBox.shrink(),
    );
  }
}
