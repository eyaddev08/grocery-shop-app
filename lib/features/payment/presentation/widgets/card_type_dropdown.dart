import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/styles.dart';
import '../../../../core/widgets/custom_dropdown_form_field.dart';


class CardTypeDropdown extends StatelessWidget {
  const CardTypeDropdown({
    super.key,
    required this.value,
    required this.onChanged,
  });

  final String value;
  final ValueChanged<String?> onChanged;

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              'CARD TYPE',
              style: textBold.copyWith(
                color: kMuted,
                fontSize: 13.5,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: CustomDropdownFormField<String>(
              value: value,
              items: const [
                DropdownMenuItem(value: 'Visa', child: Text('Visa')),
                DropdownMenuItem(
                    value: 'Mastercard', child: Text('Mastercard')),
                DropdownMenuItem(value: 'Amex', child: Text('Amex')),
              ],
              onChanged: onChanged,
            ),
          ),
        ],
      );
}
