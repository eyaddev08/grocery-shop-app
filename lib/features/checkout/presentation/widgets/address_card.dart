import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/images.dart';
import '../../../../core/widgets/custom_asset_image_widget.dart';
import '../../domain/entities/address_entity.dart';
import '../../../../core/utils/styles.dart';

class AddressCard extends StatelessWidget {
  const AddressCard(
      {super.key,
      required this.address,
      required this.onSelect,
      required this.onEdit,
      required this.onDelete});
  final AddressEntity address;
  final VoidCallback onSelect;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: onSelect,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.all(12),
          height: 96,
          decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
              side: BorderSide(
                  color: address.isDefault
                      ? kAccentYellow
                      : const Color(0x60D8D8D8),
                  width: address.isDefault ? 2 : 1),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(address.addressType, style: textBold),
                    const SizedBox(height: 16),
                    Text(address.details,
                        style: textBold.copyWith(color: kMuted)),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      InkWell(
                          onTap: onEdit,
                          child: SizedBox(
                            width: 49,
                            height: 16,
                            child: Text(
                              'Edit',
                              textAlign: TextAlign.right,
                              style: textBold.copyWith(
                                color: kPrimaryBlue,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          )),
                      const SizedBox(width: 12),
                      InkWell(
                        borderRadius: BorderRadius.circular(12),
                        onTap: onDelete,
                        child: const SizedBox(
                          width: 24,
                          height: 24,
                          child: CustomAssetImageWidget(Images.delete,
                              height: 18, width: 18),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Container(
                    width: 22,
                    height: 22,
                    decoration: BoxDecoration(
                      color: address.isDefault
                          ? kAccentYellow
                          : Colors.transparent,
                      shape: BoxShape.circle,
                      border: Border.all(
                          color: address.isDefault
                              ? kAccentYellow
                              : Colors.transparent),
                    ),
                    child: address.isDefault
                        ? const Icon(Icons.check, size: 14, color: Colors.white)
                        : const SizedBox.shrink(),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
}
