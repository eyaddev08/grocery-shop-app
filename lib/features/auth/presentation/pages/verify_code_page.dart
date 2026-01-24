// ملف مسؤول عن واجهة إدخال كود التحقق لإعادة تعيين كلمة المرور.

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_shop_app/core/constants/app_colors.dart';
import '../../../../config/routes/app_routes.dart';
import '../../../../core/services/navigation_service.dart';
import '../../../../core/utils/styles.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/custom_snackbar_widget.dart';
import '../cubit/auth_cubit.dart';
import '../cubit/auth_state.dart';
import '../widgets/auth_button.dart';
import '../widgets/frosted_glass_card.dart';
import '../widgets/loading_overlay.dart';
import '../../../../core/utils/validators.dart';
import '../widgets/title_header.dart';
import '../widgets/verify_code_field.dart';

class VerifyCodePage extends StatefulWidget {
  const VerifyCodePage({
    super.key,
    required this.email,
  });
  final String email;

  @override
  State<VerifyCodePage> createState() => _VerifyCodePageState();
}

class _VerifyCodePageState extends State<VerifyCodePage> {
  final List<TextEditingController> _controllers =
      List.generate(6, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());
  bool _isLoading = false;
  String? _codeError;

  @override
  void dispose() {
    for (final controller in _controllers) {
      controller.dispose();
    }
    for (final node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  void _onCodeChanged(int index, String value) {
    if (value.length == 1 && index < 5) {
      _focusNodes[index + 1].requestFocus();
    } else if (value.isEmpty && index > 0) {
      _focusNodes[index - 1].requestFocus();
    }

    final code = _controllers.map((c) => c.text).join();
    if (code.length == 6) {
      _validateAndSubmit(code);
    }
  }

  void _validateAndSubmit(String code) {
    setState(() {
      _codeError = Validators.code(code);
    });

    if (_codeError == null) {
      context.read<AuthCubit>().verifyResetCode(widget.email, code);
    }
  }

  @override
  Widget build(BuildContext context) => BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (!ModalRoute.of(context)!.isCurrent) return;
          if (state is AuthLoading) {
            setState(() => _isLoading = true);
          } else if (state is AuthResetCodeVerified) {
            setState(() => _isLoading = false);
            NavigationService.navigateTo(AppRoutes.resetPassword,
                arguments: state.token);
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 48),
                    FrostedGlassCard(
                        child: Column(
                      children: [
                        TitleHeader(
                            title: 'Verify Code',
                            subTitle:
                                'Enter the 6-digit code sent to\n ${widget.email}'),
                        const SizedBox(height: 24),
                        Text(_codeError ?? '',
                            style: textMedium.copyWith(color: errorColor)),
                        const SizedBox(height: 24),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: List.generate(
                              6,
                              (index) => VerifyCodeField(
                                  index: index,
                                  controllers: _controllers,
                                  focusNodes: _focusNodes,
                                  onChanged: (value) =>
                                      _onCodeChanged(index, value))),
                        ),
                      ],
                    )),
                    const SizedBox(height: 48),
                    AuthButton(
                      text: 'Verify',
                      onPressed: () {
                        final code = _controllers.map((c) => c.text).join();
                        _validateAndSubmit(code);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
}

