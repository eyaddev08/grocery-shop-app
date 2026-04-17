import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/styles.dart';
import '../../../../core/widgets/custom_snackbar_widget.dart';
import '../../domain/entities/profile_entity.dart';
import '../manager/profile_cubit.dart';
import 'profile_avatar.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key, required this.profile});
  final ProfileEntity profile;

  @override
  Widget build(BuildContext context) => Column(
        children: [
          Center(
            child: ProfileAvatar(
              avatarUrl: profile.avatarUrl,
              onImagePicked: (file) async {
                await context.read<ProfileCubit>().pickAndUploadAvatar(file);
                if (context.mounted) {
                  showCustomSnackBarWidget(
                      'Profile Avatar Uploaded Successfully', context);
                }
              },
            ),
          ),
          const SizedBox(height: 16),
          Center(
            child: Text(profile.name,
                style: textBold.copyWith(
                    fontSize: 24, fontWeight: FontWeight.bold)),
          ),
        ],
      );
}
