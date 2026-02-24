// // ملف مسؤول عن واجهة تسجيل الدخول للمستخدم.

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_shop_app/config/routes/app_routes.dart';
import 'package:grocery_shop_app/core/constants/app_colors.dart';
import 'package:grocery_shop_app/features/auth/presentation/widgets/title_header.dart';
import '../../../../core/services/navigation_service.dart';
import '../../../../core/utils/styles.dart';
import '../../../../core/utils/validators.dart';
import '../../../../core/widgets/custom_snackbar_widget.dart';
import '../manager/auth_cubit.dart';
import '../manager/auth_state.dart';
import '../widgets/auth_button.dart';
import '../widgets/email_field.dart';
import '../widgets/frosted_glass_card.dart';
import '../widgets/loading_overlay.dart';
import '../widgets/logo_card.dart';
import '../widgets/password_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  String? _emailError;
  String? _passwordError;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _validateAndSubmit() {
    setState(() {
      _emailError = Validators.email(_emailController.text);
      _passwordError = Validators.password(_passwordController.text);
    });

    if (_formKey.currentState!.validate() &&
        _emailError == null &&
        _passwordError == null) {
      context.read<AuthCubit>().login(
            _emailController.text.trim(),
            _passwordController.text,
          );
    }
  }

  @override
  Widget build(BuildContext context) => BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthLoading) {
            if (!ModalRoute.of(context)!.isCurrent) return;
            setState(() => _isLoading = true);
          } else if (state is AuthAuthenticated ||
              state is AuthUnauthenticated) {
            setState(() => _isLoading = false);
            NavigationService.navigateTo(AppRoutes.layout);
          } else if (state is AuthFailure) {
            setState(() => _isLoading = false);
            showCustomSnackBarWidget(
                state.message, sanckBarType: SnackBarType.error, context);
          }
        },
        child: Scaffold(
          backgroundColor: kSearchBlue,
          body: LoadingOverlay(
            isLoading: _isLoading,
            child: SafeArea(
              child: SingleChildScrollView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const LogoCard(),
                    const SizedBox(height: 18),
                    FrostedGlassCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const TitleHeader(
                              title: 'Welcome Back',
                              subTitle: 'Sign in to continue'),
                          const SizedBox(height: 18),
                          Form(
                            key: _formKey,
                            child: Column(
                              children: [
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
                                  validator: Validators.email,
                                ),
                                const SizedBox(height: 14),
                                PasswordField(
                                  controller: _passwordController,
                                  errorText: _passwordError,
                                  onChanged: (_) {
                                    if (_passwordError != null) {
                                      setState(() => _passwordError = null);
                                    }
                                  },
                                  hintText: 'Password',
                                ),
                                const SizedBox(height: 10),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: TextButton(
                                    onPressed: () =>
                                        NavigationService.navigateTo(
                                            AppRoutes.forgotPassword),
                                    child: Text('Forgot Password?',
                                        style: textBold.copyWith(
                                            color: kLightGrayBg)),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                AuthButton(
                                  text: 'Login',
                                  onPressed: _validateAndSubmit,
                                ),
                                const SizedBox(height: 8),
                                TextButton(
                                  onPressed: () => NavigationService.navigateTo(
                                      AppRoutes.register),
                                  child: Text('Create account',
                                      style: textBold.copyWith(
                                          color: kLightGrayBg)),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 14),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.fingerprint,
                            color: Colors.white.withOpacity(0.85), size: 18),
                        const SizedBox(width: 8),
                        Text('Secure login',
                            style: textBold.copyWith(color: Colors.white70)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
}
