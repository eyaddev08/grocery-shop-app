import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/images.dart';

class ProfileInfoSection extends StatefulWidget {
  const ProfileInfoSection({super.key, required this.user});
  final UserEntity user;

  @override
  State<ProfileInfoSection> createState() => _ProfileInfoSectionState();
}

class _ProfileInfoSectionState extends State<ProfileInfoSection> {
  File? _previewFile;
  bool _isUploading = false;

  @override
  void didUpdateWidget(covariant ProfileInfoSection oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.user.profilePicture != oldWidget.user.profilePicture) {
      if (mounted) setState(() => _previewFile = null);
    }
  }

  @override
  Widget build(BuildContext context) {
    final displayPath = _previewFile?.path ?? widget.user.profilePicture;

    return SafeArea(
      child: Column(children: [
        Stack(alignment: Alignment.bottomRight, children: [
          ProfileAvatarWidget(imagePath: displayPath, radius: 45),
          if (_isUploading)
            Positioned.fill(
                child: ColoredBox(
                    color: Colors.black.withOpacity(0.18),
                    child: const Center(
                        child: SizedBox(
                            width: 28,
                            height: 28,
                            child:
                                CircularProgressIndicator(strokeWidth: 2.5))))),
          Positioned(
            right: 0,
            bottom: 0,
            child: InkWell(
              // onTap: _isUploading ? null : _pickAndSaveLocalProfile,
              borderRadius: BorderRadius.circular(20),
              child: Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                    color: kAccentYellow,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                          color: kAccentYellow.withOpacity(0.2), blurRadius: 6)
                    ]),
                child: const Icon(Icons.edit, size: 16, color: Colors.white),
              ),
            ),
          ),
        ]),
        const SizedBox(height: 16),
        Text(widget.user.fullName,
            style: const TextStyle(
                fontSize: 24, fontWeight: FontWeight.bold, color: kSoftBg)),
        const SizedBox(height: 4),
        Text(widget.user.email,
            style: const TextStyle(
              fontSize: 16,
              color: kSoftBg,
            )),
      ]),
    );
  }
}

class ProfileAvatarWidget extends StatefulWidget {
  const ProfileAvatarWidget(
      {super.key,
      required this.imagePath,
      this.radius = 40,
      this.fallbackAsset = Images.personIcon});
  final String? imagePath;
  final double radius;
  final String fallbackAsset;

  @override
  State<ProfileAvatarWidget> createState() => _ProfileAvatarWidgetState();
}

class _ProfileAvatarWidgetState extends State<ProfileAvatarWidget> {
  ImageProvider _provider = const AssetImage(Images.personIcon);
  String? _lastPath;

  @override
  void initState() {
    super.initState();
    _resolveProvider();
  }

  @override
  void didUpdateWidget(covariant ProfileAvatarWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.imagePath != oldWidget.imagePath) _resolveProvider();
  }

  void _resolveProvider() {
    final raw = widget.imagePath;
    final path = (raw ?? '').trim();
    if (path == _lastPath) return;
    _lastPath = path;

    ImageProvider<Object> next = AssetImage(widget.fallbackAsset);

    if (path.isEmpty) {
      next = AssetImage(widget.fallbackAsset);
    } else if (path.startsWith('http://') || path.startsWith('https://')) {
      next = NetworkImage(path);
    } else if (kIsWeb) {
      next = AssetImage(widget.fallbackAsset);
    } else {
      try {
        String filePath = path.startsWith('file://')
            ? path.replaceFirst('file://', '')
            : path;
        final file = File(filePath);
        final exists = file.existsSync();
        next = exists
            ? FileImage(file) as ImageProvider<Object>
            : AssetImage(widget.fallbackAsset);
      } catch (_) {
        next = AssetImage(widget.fallbackAsset);
      }
    }

    final prev = _provider;
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      try {
        await prev.evict();
      } catch (_) {}
      if (mounted) setState(() => _provider = next);
    });
  }

  @override
  Widget build(BuildContext context) => CircleAvatar(
      radius: widget.radius,
      backgroundColor: Colors.grey.shade200,
      child: Container(
        decoration: BoxDecoration(image: DecorationImage(image: _provider)),
      ));
}

class UserEntity {
  const UserEntity({
    required this.id,
    required this.username,
    required this.fullName,
    required this.email,
    required this.phone,
    this.profilePicture,
    this.deviceToken,
  });

  factory UserEntity.fromMap(Map<String, dynamic> m) => UserEntity(
        id: m['id']?.toString() ?? '',
        username: m['username']?.toString() ?? '',
        fullName: m['fullName']?.toString() ?? '',
        email: m['email']?.toString() ?? '',
        phone: m['phone']?.toString() ?? '',
        profilePicture: m['profilePicture']?.toString(),
        deviceToken: m['deviceToken']?.toString(),
      );
  final String id;
  final String username;
  final String fullName;
  final String email;
  final String phone;
  final String? profilePicture;
  final String? deviceToken;

  UserEntity copyWith({
    String? id,
    String? username,
    String? fullName,
    String? email,
    String? phone,
    String? profilePicture,
    String? deviceToken,
  }) =>
      UserEntity(
        id: id ?? this.id,
        username: username ?? this.username,
        fullName: fullName ?? this.fullName,
        email: email ?? this.email,
        phone: phone ?? this.phone,
        profilePicture: profilePicture ?? this.profilePicture,
        deviceToken: deviceToken ?? this.deviceToken,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'username': username,
        'fullName': fullName,
        'email': email,
        'phone': phone,
        'profilePicture': profilePicture,
        'deviceToken': deviceToken,
      };

  @override
  String toString() => 'UserEntity(id:$id, username:$username, email:$email)';
}
