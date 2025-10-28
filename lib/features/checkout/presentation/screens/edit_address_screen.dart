import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/custom_themes.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/custom_dropdown_form_field.dart';
import '../../../../core/widgets/custom_button_widget.dart';
import '../../domain/entities/address.dart';
import '../manager/address_cubit.dart';
import '../widgets/custom_input_field.dart';

class EditAddressScreen extends StatefulWidget {
  const EditAddressScreen({super.key, required this.address});
  final Address address;

  @override
  State<EditAddressScreen> createState() => _EditAddressScreenState();
}

class _EditAddressScreenState extends State<EditAddressScreen> {
  final _formKey = GlobalKey<FormState>();
  late String label;
  late TextEditingController _detailsController;

  @override
  void initState() {
    super.initState();
    label = widget.address.label;
    _detailsController = TextEditingController(text: widget.address.details);
  }

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
            CustomButton(
              onTap: () async {
                if (_formKey.currentState?.validate() ?? false) {
                  await cubit.editAddress(
                      id: widget.address.id,
                      label: label,
                      details: _detailsController.text.trim());
                  Navigator.of(context).pop();
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
