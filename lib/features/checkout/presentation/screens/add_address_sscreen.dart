import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_shop_app/core/widgets/custom_app_bar.dart';

import '../../../../core/services/navigation_service.dart';
import '../../../../core/widgets/custom_button_widget.dart';
import '../manager/checkout_cubit.dart';
import '../widgets/address_type_list_view_builder.dart';
import '../widgets/custom_input_field.dart';

class AddAddressScreen extends StatefulWidget {
  const AddAddressScreen({super.key});

  @override
  State<AddAddressScreen> createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  final _formKey = GlobalKey<FormState>();

  final _detailsController = TextEditingController();

  @override
  void dispose() {
    _detailsController.dispose();

    super.dispose();
  }

  @override
  void initState() {
    context.read<CheckoutCubit>().getAddressTypes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CheckoutCubit>();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: CustomAppBar(
            title: 'Add New Address',
          )),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(height: 12),
                  CustomInputField(
                    controller: _detailsController,
                    label: 'Address details',
                    minLines: 2,
                    maxLines: 3,
                    keyboardType: TextInputType.multiline,
                    filled: true,
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 14),
                  ),
                  const SizedBox(height: 20),
                  const AddressTypeListViewBuilder(),
                  const SizedBox(height: 20),
                ],
              ),
            ),
            const Spacer(),
            CustomButton(
              onTap: () async {
                if (_formKey.currentState?.validate() ?? false) {
                  await cubit.createAddress(
                      label:
                          cubit.addressTypeList[cubit.selectAddressIndex].title,
                      addressType:
                          cubit.addressTypeList[cubit.selectAddressIndex].title,
                      details: _detailsController.text.trim());
                  NavigationService.goBack();
                }
              },
              buttonText: 'Save Address',
            ),
          ],
        ),
      ),
    );
  }
}
