import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/validators.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/custom_snackbar_widget.dart';
import '../../../../core/widgets/confirm_dialog_widget.dart';
import '../../domain/entities/profile_entity.dart';
import '../manager/profile_cubit.dart';
import '../widgets/loading_overlay.dart';
import '../widgets/profile_action_button.dart';
import '../widgets/profile_field.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _phoneController;
  late TextEditingController _emailController;
  late TextEditingController _streetController;
  late TextEditingController _cityController;
  late TextEditingController _regionController;
  late TextEditingController _postalCodeController;
  late TextEditingController _countryController;

  late ProfileEntity _initialProfile;

  @override
  void initState() {
    super.initState();
    final state = context.read<ProfileCubit>().state;
    _initialProfile = state is ProfileLoaded
        ? state.profile
        : (state as ProfileUpdating).profile;

    _nameController = TextEditingController(text: _initialProfile.name);
    _phoneController = TextEditingController(text: _initialProfile.phone);
    _emailController = TextEditingController(text: _initialProfile.email);
    _streetController =
        TextEditingController(text: _initialProfile.address?.street);
    _cityController =
        TextEditingController(text: _initialProfile.address?.city);
    _regionController =
        TextEditingController(text: _initialProfile.address?.region);
    _postalCodeController =
        TextEditingController(text: _initialProfile.address?.postalCode);
    _countryController =
        TextEditingController(text: _initialProfile.address?.country);
  }

  bool _hasChanges() =>
      _nameController.text != _initialProfile.name ||
      _phoneController.text != (_initialProfile.phone ?? '') ||
      _emailController.text != _initialProfile.email ||
      _streetController.text != (_initialProfile.address?.street ?? '') ||
      _cityController.text != (_initialProfile.address?.city ?? '') ||
      _regionController.text != (_initialProfile.address?.region ?? '') ||
      _postalCodeController.text !=
          (_initialProfile.address?.postalCode ?? '') ||
      _countryController.text != (_initialProfile.address?.country ?? '');

  Future<void> _handleSave() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    if (!_hasChanges()) return;

    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => ConfirmDialogWidget(
        title: 'Save Changes',
        description: 'Are you sure you want to update your profile?',
        icon: Icons.person,
        onPressed: () => Navigator.of(context).pop(true),
        onCancle: () => Navigator.of(context).pop(false),
        titleButton: 'Save',
      ),
    );

    if (confirm == true) {
      if (!mounted) return;
      final updated = ProfileEntity(
        id: _initialProfile.id,
        name: _nameController.text,
        email: _emailController.text,
        phone: _phoneController.text.isEmpty ? null : _phoneController.text,
        address: UserAddress(
          street:
              _streetController.text.isEmpty ? null : _streetController.text,
          city: _cityController.text.isEmpty ? null : _cityController.text,
          region:
              _regionController.text.isEmpty ? null : _regionController.text,
          postalCode: _postalCodeController.text.isEmpty
              ? null
              : _postalCodeController.text,
          country:
              _countryController.text.isEmpty ? null : _countryController.text,
        ),
        avatarUrl: _initialProfile.avatarUrl,
        createdAt: _initialProfile.createdAt,
      );
      await context.read<ProfileCubit>().editProfile(updated);
      await context.read<ProfileCubit>().saveProfile();
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: const Color(0xFFFFFFFF),
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: CustomAppBar(
            title: 'Edit Profile',
          ),
        ),
        body: BlocConsumer<ProfileCubit, ProfileState>(
          listener: (context, state) {
            if (state is ProfileLoaded) {
              showCustomSnackBarWidget('Profile updated successfully', context);
              Navigator.of(context).pop();
            } else if (state is ProfileError) {
              showCustomSnackBarWidget(state.message, context);
            }
          },
          builder: (context, state) => LoadingOverlay(
            isLoading: state is ProfileUpdating && state.isSaving,
            child: Form(
              key: _formKey,
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  ProfileField(
                    controller: _nameController,
                    label: 'Name',
                    validator: Validators.name,
                    inputType: TextInputType.name,
                  ),
                  ProfileField(
                    controller: _phoneController,
                    label: 'Phone',
                    validator: Validators.phone,
                    inputType: TextInputType.phone,
                  ),
                  ProfileField(
                    controller: _emailController,
                    label: 'Email',
                    validator: Validators.email,
                    inputType: TextInputType.emailAddress,
                  ),
                  ProfileField(
                    controller: _streetController,
                    label: 'Street',
                    validator: Validators.address,
                    inputType: TextInputType.streetAddress,
                  ),
                  ProfileField(
                    controller: _cityController,
                    label: 'City',
                    validator: Validators.city,
                    inputType: TextInputType.streetAddress,
                  ),
                  ProfileField(
                    controller: _regionController,
                    label: 'Region',
                  ),
                  ProfileField(
                    controller: _postalCodeController,
                    label: 'Postal Code',
                    validator: Validators.number,
                    inputType: TextInputType.number,
                  ),
                  ProfileField(
                    controller: _countryController,
                    label: 'Country',
                    validator: Validators.country,
                    inputType: TextInputType.streetAddress,
                  ),
                  const SizedBox(height: 32),
                  ProfileActionButton(
                    label: 'Save',
                    onPressed: _handleSave,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}
