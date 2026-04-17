import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../utils/styles.dart';
import '../utils/images.dart';
import 'custom_asset_image_widget.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,
    this.title = '',
    this.arrIconColor = kTextDark,
    this.trailing,
  });

  final String? title;
  final Color arrIconColor;

  /// Optional widget displayed on the right side (e.g. an action button).
  final Widget? trailing;

  @override
  Widget build(BuildContext context) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: kTextDark.withOpacity(0.06),
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  padding: EdgeInsets.zero,
                  icon: CustomAssetImageWidget(
                    Images.arrIcon,
                    height: 12,
                    width: 12,
                    color: arrIconColor.withOpacity(0.8),
                  ),
                  onPressed: () => Navigator.of(context).maybePop(),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title!,
                  style: titleHeader.copyWith(
                    color: kTextDark.withOpacity(0.8),
                    fontSize: 19,
                    fontWeight: FontWeight.w400,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (trailing != null) ...[
                const SizedBox(width: 12),
                trailing!,
              ],
            ],
          ),
        ),
      );
}
