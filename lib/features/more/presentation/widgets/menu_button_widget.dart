import 'package:flutter/material.dart';
import 'package:grocery_shop_app/core/constants/app_colors.dart';

import '../../../../core/utils/custom_themes.dart';
import '../../../../core/utils/dimensions.dart';
import '../../../../core/widgets/custom_asset_image_widget.dart';

class MenuButtonWidget extends StatelessWidget {
  const MenuButtonWidget(
      {super.key,
      required this.image,
      required this.title,
      this.isNotification = false,
      this.isProfile = false,
      this.trailing,
      this.onTap});
  final String image;
  final String? title;

  final Widget? trailing;
  final bool isNotification;
  final bool isProfile;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) => ListTile(
      trailing: trailing,
      contentPadding: const EdgeInsets.only(left: 16),
      leading: CustomAssetImageWidget(
        image,
        width: 25,
        height: 25,
        fit: BoxFit.fill,
        color: kAccentYellow.withOpacity(0.9),
      ),
      title: Text(title!,
          style: titilliumRegular.copyWith(
              fontSize: Dimensions.fontSizeLarge, color: kTextDark)),
      onTap: onTap);
}
