import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_shop_app/config/routes/app_routes.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/helpers/card_number_input_formatter.dart';
import '../../../../core/helpers/expiry_input_formatter.dart';
import '../../../../core/helpers/validate_check.dart';
import '../../../../core/services/navigation_service.dart';
import '../../../../core/utils/custom_themes.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/custom_button_widget.dart';
import '../../../../core/widgets/custom_dropdown_form_field.dart';
import '../../../../core/widgets/custom_snackbar_widget.dart';
import '../../../../core/widgets/custom_textfield_widget.dart';
import '../../../cart/presentation/manager/cart_cubit.dart';
import '../../../cart/presentation/widgets/cart_summary_section.dart';
import '../../domain/entiites/card_info.dart';
import '../manager/payment_cubit/payment_cubit.dart';

class AddCardScreen extends StatefulWidget {
  const AddCardScreen({super.key, required this.amount});
  final double amount;

  @override
  State<AddCardScreen> createState() => _AddCardScreenState();
}

class _AddCardScreenState extends State<AddCardScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController(text: 'John Smith');
  final _cardCtrl = TextEditingController();
  final _expCtrl = TextEditingController();
  final _cvcCtrl = TextEditingController();
  String _brand = 'Visa';

  @override
  void dispose() {
    _nameCtrl.dispose();
    _cardCtrl.dispose();
    _expCtrl.dispose();
    _cvcCtrl.dispose();
    super.dispose();
  }

  void _submit() {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    final card = CardInfo(
      holderName: _nameCtrl.text.trim(),
      number: _cardCtrl.text.trim(),
      expiry: _expCtrl.text.trim(),
      cvc: _cvcCtrl.text.trim(),
      brand: _brand,
    );
    context
        .read<PaymentCubit>()
        .tokenizeAndPay(card: card, amount: widget.amount);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.white,
        appBar: const PreferredSize(
            preferredSize: Size.fromHeight(50),
            child: CustomAppBar(title: 'Add Card')),
        body: BlocListener<PaymentCubit, PaymentState>(
          listener: (context, state) {
            if (state is PaymentSuccess) {
              final tx = state.result;
              showCustomSnackBarWidget(
                  'Payment success ${tx.transactionId}', context);

              NavigationService.navigateAndReplace(AppRoutes.layout);
            } else if (state is PaymentFailureState) {
              showCustomSnackBarWidget(
                  'Payment failed: ${state.message}', context,
                  sanckBarType: SnackBarType.error);
            }
          },
          child: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Column(
                children: [
                  const SizedBox(height: 8),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'CARD TYPE',
                              style: textBold.copyWith(
                                color: kMuted,
                                fontSize: 13.5,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: CustomDropdownFormField<String>(
                            value: _brand,
                            items: const [
                              DropdownMenuItem(
                                  value: 'Visa', child: Text('Visa')),
                              DropdownMenuItem(
                                  value: 'Mastercard',
                                  child: Text('Mastercard')),
                              DropdownMenuItem(
                                  value: 'Amex', child: Text('Amex')),
                            ],
                            onChanged: (v) =>
                                setState(() => _brand = v ?? 'Visa'),
                          ),
                        ),
                        const SizedBox(height: 18),
                        CustomTextFieldWidget(
                          controller: _nameCtrl,
                          inputType: TextInputType.name,
                          capitalization: TextCapitalization.words,
                          validator: (v) => ValidateCheck.nonEmpty(
                              v, 'Enter card holder name'),
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
                  ),
                  const SizedBox(height: 108),
                  BlocBuilder<CartCubit, CartState>(
                    builder: (context, state) {
                      if (state is CartLoaded) {
                        final items = state.items;

                        final subtotal = items.fold<double>(
                            0, (s, it) => s + it.price * it.quantity);
                        final shipping = items.isEmpty ? 0.0 : 3.5;
                        final tax = subtotal * 0.05;
                        final total = subtotal + shipping + tax;
                        return CartSummarySection(
                          subtotal: subtotal,
                          delivery: shipping,
                          total: total,
                          button: BlocBuilder<PaymentCubit, PaymentState>(
                            builder: (context, state) {
                              final isLoading = state is PaymentLoading;
                              return CustomButton(
                                  buttonText: 'Make Payment',
                                  onTap: isLoading ? null : _submit,
                                  isLoading: isLoading);
                            },
                          ),
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}
