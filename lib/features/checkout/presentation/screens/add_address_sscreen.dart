import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_shop_app/core/widgets/custom_app_bar.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/custom_themes.dart';
import '../../../../core/widgets/custom_dropdown_form_field.dart';
import '../manager/address_cubit.dart';
import '../widgets/custom_input_field.dart';

class AddAddressScreen extends StatefulWidget {
  const AddAddressScreen({super.key});

  @override
  State<AddAddressScreen> createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  final _formKey = GlobalKey<FormState>();
  String label = 'Home';
  final _detailsController = TextEditingController();

  @override
  void dispose() {
    _detailsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AddressCubit>();
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
                  CustomDropdownFormField<String>(
                    value: label,
                    items: [
                      DropdownMenuItem(
                          value: 'Home',
                          child: Text('Home',
                              style: textMedium.copyWith(
                                  fontWeight: FontWeight.w400))),
                      DropdownMenuItem(
                          value: 'Office',
                          child: Text('Office',
                              style: textMedium.copyWith(
                                  fontWeight: FontWeight.w400))),
                    ],
                    onChanged: (v) => setState(() => label = v ?? 'Home'),
                    label: 'Label',
                  ),
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
                ],
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState?.validate() ?? false) {
                    await cubit.createAddress(
                        label: label, details: _detailsController.text.trim());
                    Navigator.of(context).pop();
                  }
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: kPrimaryBlue,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20))),
                child:
                    const Text('Save Address', style: TextStyle(fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
