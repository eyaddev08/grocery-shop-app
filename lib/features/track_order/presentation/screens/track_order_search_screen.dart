import 'package:flutter/material.dart';
import 'package:grocery_shop_app/core/constants/app_colors.dart';
import 'package:grocery_shop_app/core/utils/images.dart';

import '../../../../Core/utils/dimensions.dart';
import '../../../../core/utils/styles.dart';
import '../../../../core/utils/validators.dart';
import '../../../../core/widgets/custom_app_bar_widget.dart';
import '../../../../core/widgets/custom_asset_image_widget.dart';
import '../../../../core/widgets/custom_button_widget.dart';
import '../../../profile/presentation/widgets/profile_field.dart';

class TrackOrderSearchScreen extends StatefulWidget {
  const TrackOrderSearchScreen({super.key});

  @override
  State<TrackOrderSearchScreen> createState() => _TrackOrderSearchScreenState();
}

class _TrackOrderSearchScreenState extends State<TrackOrderSearchScreen> {
  TextEditingController orderIdController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final double widthSize = MediaQuery.sizeOf(context).width;

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: CustomAppBarWidget(
            label: 'Track Order',
            labelSize: 19,
            labelColor: Color(0xFF1E222B),
            backgroundColor: Colors.white,
            isBackButtonExist: true,
            showCartIcon: false,
            showSearchIcon: false,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: Dimensions.paddingSizeExtraLarge),
          child: Form(
            key: formKey,
            child: ListView(physics: const ClampingScrollPhysics(), children: [
              const SizedBox(height: Dimensions.paddingSizeOverLarge),
              Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                CustomAssetImageWidget(
                  Images.deliveryImage,
                  height: widthSize * 0.34,
                  width: widthSize * 0.34,
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: Dimensions.paddingSizeDefault),
                    child: Text(
                      'Enter your order id and phone number to get delivery updates',
                      style: textRegular.copyWith(
                          color: kTextDark.withOpacity(0.8)),
                      textAlign: TextAlign.center,
                    )),
              ]),
              const SizedBox(height: Dimensions.paddingSizeThirtyFive),
              ProfileField(
                controller: orderIdController,
                prefixIcon: Images.orderId,
                prefixColor: kPrimaryBlue,
                isAmount: true,
                inputType: TextInputType.phone,
                hintText: 'Enter order id',
                prefixHeight: 12,
                label: 'Order id',
                required: true,
                showLabelText: true,
                capitalization: TextCapitalization.characters,
                validator: Validators.orderId,
              ),
              const SizedBox(height: Dimensions.paddingSizeExtraLarge),
              ProfileField(
                isAmount: true,
                inputType: TextInputType.phone,
                prefixIcon: Images.phone,
                prefixColor: kPrimaryBlue,
                controller: phoneNumberController,
                inputAction: TextInputAction.done,
                hintText: 'Enter phone number',
                required: true,
                label: 'Phone number',
                showLabelText: true,
                validator: Validators.phone,
              ),
              const SizedBox(height: Dimensions.paddingSizeExtraSmall),
              Padding(
                padding: const EdgeInsets.only(left: 0),
                child: Text(
                  'Please include your country code before the phone number',
                  style: textRegular.copyWith(color: kMuted),
                  textAlign: TextAlign.start,
                ),
              ),
              const SizedBox(height: Dimensions.paddingSizeExtraOverLarge),
              CustomButton(
                // isLoading: orderTrackingProvider.searching,
                buttonText: 'Track Order',
                onPressed: () async {
                  FocusManager.instance.primaryFocus?.unfocus();
                 
                 
                },
              ),
            ]),
          ),
        ));
  }
}
