// ملف مسؤول عن واجهة إعادة تعيين كلمة المرور النهائية.

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_shop_app/core/constants/app_colors.dart';
import '../../../../config/routes/app_routes.dart';
import '../../../../core/services/navigation_service.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/custom_snackbar_widget.dart';
import '../cubit/auth_cubit.dart';
import '../cubit/auth_state.dart';
import '../widgets/frosted_glass_card.dart';
import '../widgets/password_field.dart';
import '../widgets/auth_button.dart';
import '../widgets/loading_overlay.dart';
import '../../../../core/utils/validators.dart';
import '../widgets/title_header.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({
    super.key,
    required this.token,
  });
  final String token;

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isLoading = false;
  String? _passwordError;
  String? _confirmPasswordError;

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _validateAndSubmit() {
    setState(() {
      _passwordError = Validators.password(_passwordController.text);
      _confirmPasswordError = Validators.confirmPassword(
        _confirmPasswordController.text,
        _passwordController.text,
      );
    });

    if (_formKey.currentState!.validate() &&
        _passwordError == null &&
        _confirmPasswordError == null) {
      context.read<AuthCubit>().resetPassword(
            token: widget.token,
            password: _passwordController.text,
            passwordConfirmation: _confirmPasswordController.text,
          );
    }
  }

  @override
  Widget build(BuildContext context) => BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthLoading) {
            setState(() => _isLoading = true);
          } else if (state is AuthUnauthenticated) {
            setState(() => _isLoading = false);
            showCustomSnackBarWidget(
                'Password reset successfully',
                isError: false,
                context,
                isToaster: true);

            NavigationService.navigateAndClearStack(AppRoutes.login);
          } else if (state is AuthFailure) {
            setState(() => _isLoading = false);
            showCustomSnackBarWidget(
              state.message,
              sanckBarType: SnackBarType.error,
              context,
            );
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
                                title: 'Reset Password',
                                subTitle: 'Enter your new password'),
                            const SizedBox(height: 48),
                            PasswordField(
                              controller: _passwordController,
                              errorText: _passwordError,
                              showStrengthMeter: true,
                              onChanged: (_) {
                                if (_passwordError != null) {
                                  setState(() => _passwordError = null);
                                }
                                setState(() {}); // Update strength meter
                              },
                            ),
                            const SizedBox(height: 16),
                            PasswordField(
                              controller: _confirmPasswordController,
                              errorText: _confirmPasswordError,
                              hintText: 'Confirm Password',
                              onChanged: (_) {
                                if (_confirmPasswordError != null) {
                                  setState(() => _confirmPasswordError = null);
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 48),
                      AuthButton(
                        text: 'Reset Password',
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
