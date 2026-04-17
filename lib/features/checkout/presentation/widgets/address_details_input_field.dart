import 'package:flutter/material.dart';

import 'custom_input_field.dart';

class AddressDetailsInputField extends StatelessWidget {
  const AddressDetailsInputField({
    super.key,
    required this.controller,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) => CustomInputField(
      controller: controller,
      label: 'Address details',
      minLines: 2,
      maxLines: 3,
      keyboardType: TextInputType.multiline,
      filled: true,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 14,
      ),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Address is required';
        }
        return null;
      },
    );
}
