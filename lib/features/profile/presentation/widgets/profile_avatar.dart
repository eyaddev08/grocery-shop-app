import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/images.dart';

class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar({super.key, this.avatarUrl, required this.onImagePicked});
  final String? avatarUrl;
  final void Function(File) onImagePicked;

  @override
  Widget build(BuildContext context) => Stack(
        children: [
          CircleAvatar(
            radius: 48,
            backgroundColor: kPrimaryBlue.withOpacity(0.2),
            child: avatarUrl != null && avatarUrl!.isNotEmpty
                ? avatarUrl!.startsWith('http')
                    ? CachedNetworkImage(
                        imageUrl: avatarUrl!,
                        placeholder: (context, url) => const Center(
                            child: CircularProgressIndicator(
                                color: kAccentYellow)),
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
                              image: FileImage(File(avatarUrl!)),
                              fit: BoxFit.cover),
                        ),
                      )
                : Image.asset(Images.personIcon, fit: BoxFit.cover),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: GestureDetector(
              onTap: _pickImage,
              child: Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: const Color(0xFF1E66C8),
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child:
                    const Icon(Icons.camera_alt, color: Colors.white, size: 18),
              ),
            ),
          ),
        ],
      );

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      onImagePicked(File(pickedFile.path));
    }
  }
}
