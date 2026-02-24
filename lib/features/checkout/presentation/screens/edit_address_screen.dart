import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/services/navigation_service.dart';

import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/custom_button_widget.dart';
import '../../domain/entities/address.dart';
import '../manager/checkout_cubit.dart';
import '../widgets/address_type_list_view_builder.dart';
import '../widgets/custom_input_field.dart';

class EditAddressScreen extends StatefulWidget {
  const EditAddressScreen({super.key, required this.address});
  final Address address;

  @override
  State<EditAddressScreen> createState() => _EditAddressScreenState();
}

class _EditAddressScreenState extends State<EditAddressScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _detailsController;

  @override
  void initState() {
    super.initState();
    _detailsController = TextEditingController(text: widget.address.details);

    context.read<CheckoutCubit>().getAddressTypes();
    final cubit = context.read<CheckoutCubit>();
    final at = widget.address.addressType;
    if (at == 'Home') {
      cubit.updateAddressIndex(0, false);
    } else if (at == 'Workplace') {
      cubit.updateAddressIndex(1, false);
    } else {
      cubit.updateAddressIndex(2, false);
    }
  }

  @override
  void dispose() {
    _detailsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CheckoutCubit>();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: CustomAppBar(title: 'Edit Address'),
      ),
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
                  const SizedBox(height: 12),
                  const AddressTypeListViewBuilder(),
                ],
              ),
            ),
            const Spacer(),
            CustomButton(
              onTap: () async {
                if (_formKey.currentState?.validate() ?? false) {
                  final type = (cubit.addressTypeList.isNotEmpty &&
                          cubit.selectAddressIndex <
                              cubit.addressTypeList.length)
                      ? cubit.addressTypeList[cubit.selectAddressIndex].title
                      : widget.address.addressType;
                  await cubit.editAddress(
                    id: widget.address.id,
                    label: widget.address.label,
                    addressType: type,
                    details: _detailsController.text.trim(),
                  );
                  NavigationService.goBack();
                }
              },
              buttonText: 'Save Changes',
            ),
          ],
        ),
      ),
    );
  }
}
