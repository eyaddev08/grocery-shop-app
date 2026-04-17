import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../config/routes/app_routes.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/services/navigation_service.dart';
import '../../../../core/utils/styles.dart';
import '../../../../core/widgets/custom_snackbar_widget.dart';
import '../manager/auth_cubit.dart';
import '../manager/auth_state.dart';
import '../widgets/email_field.dart';
import '../widgets/frosted_glass_card.dart';
import '../widgets/logo_card.dart';
import '../widgets/password_field.dart';
import '../widgets/auth_button.dart';
import '../widgets/loading_overlay.dart';
import '../../../../core/utils/validators.dart';
import '../widgets/title_header.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isLoading = false;
  bool _acceptTerms = false;
  String? _nameError;
  String? _emailError;
  String? _passwordError;
  String? _confirmPasswordError;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _validateAndSubmit() {
    FocusManager.instance.primaryFocus?.unfocus();

    setState(() {
      _nameError = Validators.name(_nameController.text);
      _emailError = Validators.email(_emailController.text);
      _passwordError = Validators.password(_passwordController.text);
      _confirmPasswordError = Validators.confirmPassword(
        _confirmPasswordController.text,
        _passwordController.text,
      );
    });

    if (_formKey.currentState!.validate() &&
        _nameError == null &&
        _emailError == null &&
        _passwordError == null &&
        _confirmPasswordError == null &&
        _acceptTerms) {
      context.read<AuthCubit>().register(
            name: _nameController.text.trim(),
            email: _emailController.text.trim(),
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
          } else if (state is AuthNeedsVerification) {
            setState(() => _isLoading = false);
            showCustomSnackBarWidget(
                'Account created successfully', isError: false, context);

            NavigationService.navigateAndClearStack(AppRoutes.login);
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
                padding: const EdgeInsets.all(24),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const LogoCard(),
                      const SizedBox(height: 18),
                      FrostedGlassCard(
                        child: Column(
                          children: [
                            const TitleHeader(
                                title: 'Create Account',
                                subTitle: 'Sign up to get started'),
                            const SizedBox(height: 32),
                            EmailField(
                              controller: _nameController,
                              errorText: _nameError,
                              hintText: 'Name',
                              icon: Icons.person_outlined,
                              keyboardType: TextInputType.name,
                              textInputAction: TextInputAction.next,
                              validator: Validators.name,
                              onChanged: (_) {
                                if (_nameError != null) {
                                  setState(() => _nameError = null);
                                }
                              },
                            ),
                            const SizedBox(height: 16),
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
                            const SizedBox(height: 16),
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
                            const SizedBox(height: 16),
                            Row(
                              children: [
                                Checkbox(
                                  value: _acceptTerms,
                                  checkColor: kPrimaryBlue,
                                  activeColor: kAccentYellow,
                                  onChanged: (value) {
                                    setState(
                                        () => _acceptTerms = value ?? false);
                                  },
                                ),
                                Expanded(
                                  child: Text(
                                    'I agree to the Terms and Conditions',
                                    style: textBold.copyWith(
                                        fontSize: 12, color: kLightGrayBg),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 24),
                            AuthButton(
                              text: 'Register',
                              onPressed:
                                  _acceptTerms ? _validateAndSubmit : null,
                            ),
                            const SizedBox(height: 16),
                            TextButton(
                              onPressed: () =>
                                  NavigationService.navigateTo(AppRoutes.login),
                              child: Text(
                                'Already have an account? Login',
                                style: textBold.copyWith(
                                  color: kAccentYellow,
                                ),
                              ),
                            ),
                          ],
                        ),
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
