import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';

import '../../../../core/utils/dimensions.dart';
import '../../../../core/utils/images.dart';
import '../../../../core/utils/styles.dart';
import '../../domain/entities/address.dart';

class AddressTypeWidget extends StatelessWidget {
  final Address? address;
  const AddressTypeWidget({super.key, required this.address});

  @override
  Widget build(BuildContext context) => ListTile(
        leading: Image.asset(
            address?.addressType == 'home'
                ? Images.homeImage
                : address!.addressType == 'office'
                    ? Images.officeIcon
                    : Images.locationIcon,
            color: kAccentYellow,
            height: 30,
            width: 30),
        title: Text(address?.address ?? '',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: textRegular.copyWith(
                fontSize: Dimensions.fontSizeDefault, color: kMuted)),
      );
}
