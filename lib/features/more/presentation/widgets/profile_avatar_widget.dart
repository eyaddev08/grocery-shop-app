
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/images.dart';

class ProfileAvatarWidget extends StatelessWidget {
  const ProfileAvatarWidget({
    super.key,
    this.imagePath,
    this.radius = 45,
  });
  final String? imagePath;
  final double radius;

  @override
  Widget build(BuildContext context) => CircleAvatar(
        radius: radius,
        backgroundColor: Colors.white,
        child: imagePath != null && imagePath!.isNotEmpty
            ? imagePath!.startsWith('http')
                ? CachedNetworkImage(
                    imageUrl: imagePath!,
                    placeholder: (context, url) =>
                        const CircularProgressIndicator(color: kAccentYellow),
                    errorWidget: (context, url, error) =>
                        Image.asset(Images.personIcon, fit: BoxFit.cover),
                    imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: imageProvider, fit: BoxFit.cover),
                      ),
                    ),
                  )
                : Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: FileImage(File(imagePath!)),
                          fit: BoxFit.cover),
                    ),
                  )
            : Image.asset(Images.personIcon, fit: BoxFit.cover),
      );
}