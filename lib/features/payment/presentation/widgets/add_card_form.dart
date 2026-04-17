import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/helpers/card_number_input_formatter.dart';
import '../../../../core/helpers/expiry_input_formatter.dart';
import '../../../../core/helpers/validate_check.dart';
import '../../../../core/widgets/custom_textfield_widget.dart';
import '../../domain/entiites/card_info.dart';
import 'card_type_dropdown.dart';

class AddCardForm extends StatefulWidget {
  const AddCardForm({super.key});

  @override
  AddCardFormState createState() => AddCardFormState();
}

class AddCardFormState extends State<AddCardForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController(text: 'Eyad Nabil Ali Mohammed');
  final _cardCtrl = TextEditingController(text: '6355455454636');
  final _expCtrl = TextEditingController(text: '03/24');
  final _cvcCtrl = TextEditingController(text: '7468');
  String _brand = 'Visa';

  @override
  void dispose() {
    _nameCtrl.dispose();
    _cardCtrl.dispose();
    _expCtrl.dispose();
    _cvcCtrl.dispose();
    super.dispose();
  }

  /// Validate the form, and if everything is okay return a new [CardInfo]
  /// object.  If validation fails `null` is returned.
  CardInfo? getCardIfValid() {
    if (!(_formKey.currentState?.validate() ?? false)) return null;
    return CardInfo(
      holderName: _nameCtrl.text.trim(),
      number: _cardCtrl.text.trim(),
      expiry: _expCtrl.text.trim(),
      cvc: _cvcCtrl.text.trim(),
      brand: _brand,
    );
  }

  @override
  Widget build(BuildContext context) => Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CardTypeDropdown(
              value: _brand,
              onChanged: (v) => setState(() => _brand = v ?? 'Visa'),
            ),
            const SizedBox(height: 18),
            CustomTextFieldWidget(
              controller: _nameCtrl,
              inputType: TextInputType.name,
              capitalization: TextCapitalization.words,
              validator: (v) =>
                  ValidateCheck.nonEmpty(v, 'Enter card holder name'),
              labelText: 'CARD HOLDER NAME',
              required: true,
            ),
            const SizedBox(height: 18),
            CustomTextFieldWidget(
              controller: _cardCtrl,
              inputType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(19),
                CardNumberInputFormatter(),
              ],
              validator: ValidateCheck.cardValidator,
              labelText: 'CARD NUMBER',
              required: true,
            ),
            const SizedBox(height: 18),
            Row(
              children: [
                Expanded(
                  child: CustomTextFieldWidget(
                    controller: _expCtrl,
                    inputType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(4),
                      ExpiryInputFormatter(),
                    ],
                    validator: ValidateCheck.expiryValidator,
                    labelText: 'EXP DATE',
                    required: true,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: CustomTextFieldWidget(
                    controller: _cvcCtrl,
                    inputType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(4)
                    ],
                    validator: ValidateCheck.cvcValidator,
                    labelText: 'CVC',
                    required: true,
                  ),
                ),
              ],
            ),
          ],
        ),
      );
}
