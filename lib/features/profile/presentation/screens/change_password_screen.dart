import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/validators.dart';
import '../../../../core/widgets/custom_app_bar.dart';

import '../../../../core/widgets/custom_snackbar_widget.dart';
import '../manager/profile_cubit.dart';
import '../widgets/loading_overlay.dart';
import '../widgets/profile_action_button.dart';
import '../widgets/profile_field.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _currentController = TextEditingController();
  final _newController = TextEditingController();
  final _confirmController = TextEditingController();

  bool _obscureCurrent = true;
  bool _obscureNew = true;
  bool _obscureConfirm = true;

  @override
  void dispose() {
    _currentController.dispose();
    _newController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<ProfileCubit>().changePasswordAction(
            _currentController.text,
            _newController.text,
          );
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: const Color(0xFFF7F8FB),
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: CustomAppBar(
            title: 'Change Password',
          ),
        ),
        body: BlocConsumer<ProfileCubit, ProfileState>(
          listener: (context, state) {
            if (state is ProfileActionSuccess) {
              showCustomSnackBarWidget(state.message, context);
              Navigator.of(context).pop(true);
            } else if (state is ProfileError) {
              showCustomSnackBarWidget(state.message, context, isError: true);
            }
          },
          builder: (context, state) => LoadingOverlay(
            isLoading: state is ProfileUpdating && state.isSaving,
            child: Form(
              key: _formKey,
              child: _buildPasswordFields(),
            ),
          ),
        ),
      );

  Widget _buildPasswordFields() => ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ProfileField(
            controller: _currentController,
            label: 'Current Password',
            obscureText: _obscureCurrent,
            validator: Validators.password,
            suffixIcon: IconButton(
              color: kPrimaryBlue,
              icon: Icon(
                  _obscureCurrent ? Icons.visibility_off : Icons.visibility,
                  color: Colors.grey),
              onPressed: () =>
                  setState(() => _obscureCurrent = !_obscureCurrent),
            ),
          ),
          ProfileField(
            controller: _newController,
            label: 'New Password',
            obscureText: _obscureNew,
            validator: Validators.password,
            suffixIcon: IconButton(
              color: kPrimaryBlue,
              icon: Icon(_obscureNew ? Icons.visibility_off : Icons.visibility,
                  color: Colors.grey),
              onPressed: () => setState(() => _obscureNew = !_obscureNew),
            ),
          ),
          ProfileField(
            controller: _confirmController,
            label: 'Confirm New Password',
            obscureText: _obscureConfirm,
            validator: (value) =>
                Validators.confirmPassword(value, _confirmController.text),
            suffixIcon: IconButton(
              color: kPrimaryBlue,
              icon: Icon(
                  _obscureConfirm ? Icons.visibility_off : Icons.visibility,
                  color: Colors.grey),
              onPressed: () =>
                  setState(() => _obscureConfirm = !_obscureConfirm),
            ),
          ),
          const SizedBox(height: 32),
          ProfileActionButton(
            label: 'Change Password',
            onPressed: _submit,
          ),
        ],
      );
}
