import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_shop_app/core/constants/app_colors.dart';

import '../../../../config/routes/app_routes.dart';
import '../../../../core/services/navigation_service.dart';
import '../../../../core/utils/styles.dart';
import '../../../../core/widgets/custom_app_bar_widget.dart';
import '../manager/profile_cubit.dart';
import '../widgets/loading_overlay.dart';
import '../widgets/profile_action_button.dart';
import '../widgets/profile_header.dart';
import '../widgets/profile_info_list.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: const Color(0xFFFFFFFF),
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: CustomAppBarWidget(
            label: 'Profile',
            labelSize: 19,
            labelColor: Color(0xFF1E222B),
            backgroundColor: Colors.white,
            isBackButtonExist: true,
            showCartIcon: false,
            showSearchIcon: false,
          ),
        ),
        body: BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
            if (state is ProfileLoading || state is ProfileInitial) {
              return const Center(
                  child: CircularProgressIndicator(color: kAccentYellow));
            } else if (state is ProfileLoaded || state is ProfileUpdating) {
              final profile = state is ProfileLoaded
                  ? state.profile
                  : (state as ProfileUpdating).profile;
              return LoadingOverlay(
                isLoading: state is ProfileUpdating && state.isSaving,
                child: ListView(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                  children: [
                    ProfileHeader(profile: profile),
                    const SizedBox(height: 32),
                    ProfileInfoList(profile: profile),
                    const SizedBox(height: 32),
                    ProfileActionButton(
                      label: 'Edit Profile',
                      isOutlined: true,
                      onPressed: () =>
                          NavigationService.navigateTo(AppRoutes.editProfile),
                    ),
                    const SizedBox(height: 16),
                    ProfileActionButton(
                      label: 'Change Password',
                      onPressed: () => NavigationService.navigateTo(
                          AppRoutes.changePassword),
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
              );
            } else if (state is ProfileError) {
              return Center(child: Text(state.message, style: textMedium));
            }
            return const SizedBox();
          },
        ),
      );
}
