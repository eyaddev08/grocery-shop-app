import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/dimensions.dart';
import '../../../../core/utils/styles.dart';
import '../manager/checkout_cubit.dart';
import '../manager/checkout_state.dart';

class AddressTypeListViewBuilder extends StatelessWidget {
  const AddressTypeListViewBuilder({super.key});

  @override
  Widget build(BuildContext context) => SizedBox(
        height: 50,
        child: RepaintBoundary(
          child: BlocBuilder<CheckoutCubit, CheckoutState>(
            buildWhen: (previous, current) =>
                current is CheckoutAddressTypesLoading ||
                current is CheckoutAddressTypesLoaded ||
                current is CheckoutAddressTypesError ||
                current is CheckoutUpdateAddressIndex,
            builder: (context, state) {
              final cubit = context.read<CheckoutCubit>();

              if (state is CheckoutAddressTypesLoading) {
                return ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (_, __) => Container(
                    width: 110,
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                    margin: const EdgeInsets.only(right: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: kAccentYellow.withOpacity(.12),
                    ),
                    child: Row(
                      children: [
                        Container(
                            width: 20,
                            height: 20,
                            color: Colors.white.withOpacity(.6)),
                        const SizedBox(width: 8),
                        Expanded(
                            child: Container(
                                height: 12,
                                color: Colors.white.withOpacity(.6))),
                      ],
                    ),
                  ),
                  separatorBuilder: (_, __) => const SizedBox(width: 8),
                  itemCount: 3,
                );
              }

              if (state is CheckoutAddressTypesError) {
                return const Center(
                    child:
                        Text('Error loading addresses types', style: textBold));
              }

              // For loaded or other states, if list empty show a placeholder too
              if (cubit.addressTypeList.isEmpty) {
                return const Center(
                    child: Text('No addresses types', style: textBold));
              }

              return ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                itemCount: cubit.addressTypeList.length,
                itemBuilder: (context, index) {
                  final item = cubit.addressTypeList[index];
                  final selected = cubit.selectAddressIndex == index;

                  return InkWell(
                    onTap: () => cubit.updateAddressIndex(index, true),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: Dimensions.paddingSizeDefault,
                        horizontal: Dimensions.paddingSizeLarge,
                      ),
                      margin: const EdgeInsets.only(right: 17),
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(Dimensions.paddingSizeSmall),
                        border: Border.all(
                          color: selected
                              ? kPrimaryBlue
                              : kPrimaryBlue.withOpacity(.125),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 20,
                            child: Image.asset(
                              item.icon,
                              color: selected
                                  ? kPrimaryBlue
                                  : kPrimaryBlue.withOpacity(.35),
                            ),
                          ),
                          const SizedBox(width: Dimensions.paddingSizeSmall),
                          Text(item.title,
                              style: textBold.copyWith(color: kMuted)),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      );
}
