import 'package:flutter/material.dart';

import '../../domain/entities/profile_entity.dart';
import 'info_card.dart';

class ProfileInfoList extends StatelessWidget {
  const ProfileInfoList({super.key, required this.profile});
  final ProfileEntity profile;

  @override
  Widget build(BuildContext context) => Column(
        children: [
          
          InfoCard(
              icon: Icons.email_outlined, title: 'Email', value: profile.email),
          if (profile.phone != null)
            InfoCard(
                icon: Icons.phone_outlined,
                title: 'Phone',
                value: profile.phone!),
          if (profile.address != null)
            InfoCard(
                icon: Icons.location_on_outlined,
                title: 'Address',
                value: _formatAddress(profile.address!)),
        ],
      );

  String _formatAddress(UserAddress address) =>
      '${address.street ?? ''}, ${address.city ?? ''}, ${address.region ?? ''} ${address.postalCode ?? ''}';
}
