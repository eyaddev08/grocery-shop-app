import 'package:flutter/material.dart';

import '../../../../config/routes/app_routes.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/services/navigation_service.dart';
import '../../../profile/domain/entities/profile_entity.dart';
import 'profile_avatar_widget.dart';

class ProfileInfoSection extends StatelessWidget {
  const ProfileInfoSection({super.key, required this.user});
  final ProfileEntity user;

  @override
  Widget build(BuildContext context) => SafeArea(
        child: Column(children: [
          Stack(alignment: Alignment.bottomRight, children: [
            ProfileAvatarWidget(imagePath: user.avatarUrl),
            Positioned(
              right: 0,
              bottom: 0,
              child: InkWell(
                onTap: () => NavigationService.navigateTo(AppRoutes.profile),
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                      color: kAccentYellow,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                            color: kAccentYellow.withOpacity(0.2),
                            blurRadius: 6)
                      ]),
                  child: const Icon(Icons.edit, size: 16, color: Colors.white),
                ),
              ),
            ),
          ]),
          const SizedBox(height: 16),
          Text(user.name,
              style: const TextStyle(
                  fontSize: 24, fontWeight: FontWeight.bold, color: kSoftBg)),
          const SizedBox(height: 4),
          Text(user.email,
              style: const TextStyle(
                fontSize: 16,
                color: kSoftBg,
              )),
        ]),
      );
}
