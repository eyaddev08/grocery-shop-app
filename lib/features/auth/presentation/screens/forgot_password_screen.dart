// ملف مسؤول عن واجهة طلب إعادة تعيين كلمة المرور عبر البريد.

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_shop_app/core/constants/app_colors.dart';
import '../../../../config/routes/app_routes.dart';
import '../../../../core/services/navigation_service.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/custom_snackbar_widget.dart';
import '../manager/auth_cubit.dart';
import '../manager/auth_state.dart';
import '../widgets/email_field.dart';
import '../widgets/auth_button.dart';
import '../widgets/frosted_glass_card.dart';
import '../widgets/loading_overlay.dart';
import '../../../../core/utils/validators.dart';
import '../widgets/title_header.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  bool _isLoading = false;
  String? _emailError;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _validateAndSubmit() {
    FocusManager.instance.primaryFocus?.unfocus();

    setState(() {
      _emailError = Validators.email(_emailController.text);
    });

    if (_formKey.currentState!.validate() && _emailError == null) {
      context
          .read<AuthCubit>()
          .requestPasswordReset(_emailController.text.trim());
    }
  }

  @override
  Widget build(BuildContext context) => BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (!ModalRoute.of(context)!.isCurrent) return;
          if (state is AuthLoading) {
            setState(() => _isLoading = true);
          } else if (state is AuthPasswordResetRequested) {
            setState(() => _isLoading = false);
            NavigationService.navigateTo(AppRoutes.verifyCode,
                arguments: state.email);
          } else if (state is AuthFailure) {
            setState(() => _isLoading = false);
            showCustomSnackBarWidget(
                state.message, sanckBarType: SnackBarType.error, context);
          }
        },
        child: Scaffold(
          backgroundColor: kSearchBlue,
          appBar: const PreferredSize(
            preferredSize: Size.fromHeight(58),
            child: CustomAppBar(
              arrIconColor: kLightGrayBg,
            ),
          ),
          body: LoadingOverlay(
            isLoading: _isLoading,
            child: SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 48),
                      FrostedGlassCard(
                        child: Column(
                          children: [
                            const TitleHeader(
                                title: 'Forgot Password?',
                                subTitle:
                                    'Enter your email to receive a reset code'),
                            const SizedBox(height: 48),
                            EmailField(
                              controller: _emailController,
                              errorText: _emailError,
                              hintText: 'Email',
                              icon: Icons.email_outlined,
                              keyboardType: TextInputType.emailAddress,
                              textInputAction: TextInputAction.next,
                              onChanged: (_) {
                                if (_emailError != null) {
                                  setState(() => _emailError = null);
                                }
                              },
                            ),
                            const SizedBox(height: 24),
                          ],
                        ),
                      ),
                      const SizedBox(height: 48),
                      AuthButton(
                        text: 'Send Code',
                        onPressed: _validateAndSubmit,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
}
