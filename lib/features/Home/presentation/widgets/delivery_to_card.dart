import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/routes/app_routes.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/services/navigation_service.dart';
import '../../../../core/utils/functions/show_address_menu.dart';
import '../../../../core/utils/styles.dart';
import '../../../checkout/domain/entities/address.dart';
import '../../../checkout/presentation/manager/checkout_cubit.dart';
import '../../../checkout/presentation/manager/checkout_state.dart';

class DeliveryToCard extends StatelessWidget {
  const DeliveryToCard({
    super.key,
    required this.scale,
    required this.addressKey,
  });

  final double scale;
  final GlobalKey<State<StatefulWidget>> addressKey;

  @override
  Widget build(BuildContext context) => Expanded(
        child: BlocBuilder<CheckoutCubit, CheckoutState>(
          builder: (context, state) {
            // defaults
            String displayedAddress = 'Select delivery address';
            List<Address> addresses = const [];

            if (state is CheckoutLoading) {
              displayedAddress = 'Loading address...';
            } else if (state is CheckoutEmpty) {
              displayedAddress = 'No addresses yet';
            } else if (state is CheckoutLoaded) {
              addresses = state.addresses;
              // Try resolve selected Address by selectedAddressId
              Address? selected;
              if (state.selectedAddressId != null) {
                selected = addresses.firstWhere(
                  (a) => a.id == state.selectedAddressId,
                  // orElse: () => addresses.isNotEmpty ? addresses.first : null,
                );
              } else {
                selected = addresses.isNotEmpty ? addresses.first : null;
              }

              if (selected != null) {
                // prefer label then details
                displayedAddress = '${selected.label}, ${selected.details}';
              } else {
                displayedAddress = 'No addresses yet';
              }
            } else if (state is CheckoutError) {
              displayedAddress = 'Address error';
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Opacity(
                  opacity: 0.5,
                  child: Text('DELIVERY TO',
                      style: titilliumSemiBold.copyWith(
                        color: kSoftBg,
                        fontWeight: FontWeight.w800,
                      )),
                ),
                SizedBox(height: 4 * scale),
                InkWell(
                  key: addressKey,
                  onTap: () async {
                    final cubit = context.read<CheckoutCubit>();
                    final state = cubit.state;

                    Address? picked;

                    if (state is CheckoutLoading) {
                      // Show shimmer placeholders
                      picked = await showAddressMenu(
                        context,
                        addressKey,
                        null,
                        isLoading: true,
                        onAddAddress: () =>
                            NavigationService.navigateTo(AppRoutes.addAddress),
                      );
                    } else if (state is CheckoutEmpty) {
                      // No addresses -> show add button
                      picked = await showAddressMenu(
                        context,
                        addressKey,
                        [],
                        onAddAddress: () =>
                            NavigationService.navigateTo(AppRoutes.addAddress),
                      );
                    } else if (state is CheckoutLoaded) {
                      // Show actual addresses
                      picked = await showAddressMenu(
                        context,
                        addressKey,
                        state.addresses,
                        onAddAddress: () =>
                            NavigationService.navigateTo(AppRoutes.addAddress),
                      );
                    } else {
                      // fallback: show add address
                      picked = await showAddressMenu(
                        context,
                        addressKey,
                        [],
                        onAddAddress: () =>
                            NavigationService.navigateTo(AppRoutes.addAddress),
                      );
                    }

                    if (picked != null) {
                      await cubit.chooseDefault(picked.id);
                    }
                  },
                  child: Row(
                    children: [
                      Flexible(
                          child: Text(displayedAddress,
                              style: titleRegular.copyWith(
                                color: Colors.white,
                              ))),
                      SizedBox(width: 6 * scale),
                      Icon(Icons.keyboard_arrow_down,
                          color: Colors.white, size: 18 * scale)
                    ],
                  ),
                )
              ],
            );
          },
        ),
      );
}
