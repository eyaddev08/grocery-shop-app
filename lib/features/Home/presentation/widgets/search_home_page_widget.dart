import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/styles.dart';
import '../../../../core/utils/dimensions.dart';
import '../../../../core/utils/images.dart';
import '../../../../core/widgets/custom_asset_image_widget.dart';

class SearchHomePageWidget extends StatelessWidget {
  const SearchHomePageWidget({super.key, required this.scale});
  final double scale;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(
            vertical: Dimensions.paddingSizeExtraExtraSmall),
        child: Container(
          padding: EdgeInsets.symmetric(
              horizontal: 16 * scale, vertical: 14 * scale),
          decoration: BoxDecoration(
              color: kSearchBlue, borderRadius: BorderRadius.circular(28)),
          child: Row(
            children: [
              CustomAssetImageWidget(Images.searchIcon,
                  color: Colors.white60, height: 18 * scale),
              SizedBox(width: 12 * scale),
              Expanded(
                  child: Text('Search Products or store',
                      style: titleRegular.copyWith(
                        color: kNavInactive,
                      )))
            ],
          ),
        ),
      );
}
