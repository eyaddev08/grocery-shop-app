import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../utils/custom_themes.dart';
import '../utils/dimensions.dart';
import 'custom_button_widget.dart';

class DeletFromAddressShowDialog extends StatelessWidget {
  const DeletFromAddressShowDialog({
    super.key,
    // required this.addressId, required this.index
  });
  // final String addressId;
  // final int index;

  @override
  Widget build(BuildContext context) => SizedBox(
        height: 200,
        width: 275,
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: Dimensions.paddingSizeExtraSmall),
          child: Material(
            borderRadius:
                const BorderRadius.all(Radius.circular(Dimensions.radiusLarge)),
            child: Container(
              padding: const EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
              decoration: const BoxDecoration(
                  color: kSoftBg,
                  borderRadius: BorderRadius.all(
                      Radius.circular(Dimensions.radiusLarge))),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: Dimensions.paddingSizeExtraSmall),
                    child: SizedBox(
                      width: 40,
                      child: Image.asset('assets/images/delete.png'),
                    ),
                  ),
                  const SizedBox(
                    height: Dimensions.paddingSizeSmall,
                  ),
                  Text(
                    'Delete address ?',
                    style: textBold.copyWith(
                        fontSize: Dimensions.fontSizeLarge, color: kTextGray),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text('Are you sure you want to delete this address?',
                        textAlign: TextAlign.center,
                        style: titleRegular.copyWith(color: kTextGray)),
                  ),
                  const SizedBox(height: Dimensions.paddingSizeExtraSmall),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: Dimensions.paddingSizeExtraSmall),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                            width: 100,
                            child: CustomButton(
                              buttonText: 'cancel',
                              buttonHeight: 40,
                              fontSize: 13,
                              backgroundColor: kPrimaryBlue,
                              textColor: kSoftBg,
                              onTap: () => Navigator.of(context).pop(false),
                            )),
                        const SizedBox(
                          width: Dimensions.paddingSizeDefault,
                        ),
                        SizedBox(
                            width: 100,
                            child: CustomButton(
                                buttonText: 'remove',
                                buttonHeight: 40,
                                fontSize: 13,
                                backgroundColor:
                                    Theme.of(context).colorScheme.error,
                                onTap: () {
                                  // context.read<AddressCubit>().removeAddress('addressId');
                                  // Navigator.of(context).pop();
                                  Navigator.of(context).pop(true);
                                }))
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      );
}
