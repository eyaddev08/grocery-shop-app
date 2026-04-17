import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/images.dart';
import '../../../../core/widgets/custom_asset_image_widget.dart';

class AddNewAddressCard extends StatelessWidget {
  const AddNewAddressCard({super.key, required this.onTap});
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: onTap,
        splashColor: kPrimaryBlue.withOpacity(.3),
        borderRadius: BorderRadius.circular(20),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 18),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: kMuted.withOpacity(.1), width: 2),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: kAccentYellow)),
                child: const Center(
                    child: CustomAssetImageWidget(Images.addIcon,
                        color: kAccentYellow, height: 28, width: 28)),
              ),
              const SizedBox(width: 12),
              Text('Add New Address',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: kTextDark.withOpacity(0.9),
                  )),
            ],
          ),
        ),
      );
}
