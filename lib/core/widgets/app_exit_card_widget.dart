import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:grocery_shop_app/core/constants/app_constants.dart';
import '../utils/custom_themes.dart';
import '../utils/dimensions.dart';
import 'custom_button_widget.dart';

class AppExitCard extends StatelessWidget {
  const AppExitCard({super.key});

  @override
  Widget build(BuildContext context) => Material(
        color: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.only(bottom: 20, top: 15),
          margin: const EdgeInsets.symmetric(horizontal: 40),
          decoration: const BoxDecoration(
              color: Color(0xFF142F74),
              borderRadius: BorderRadius.all(
                  Radius.circular(Dimensions.paddingSizeDefault))),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: Dimensions.paddingSizeDefault),
                child: SizedBox(
                    width: 60,
                    child: Image.asset(
                      'assets/images/logout.png',
                      color: yellow,
                    )),
              ),
              const SizedBox(
                height: Dimensions.paddingSizeExtraSmall,
              ),
              Text(
                'Close App',
                style: textBold.copyWith(
                    fontSize: Dimensions.fontSizeLarge,
                    color: Theme.of(context).textTheme.bodyLarge?.color),
              ),
              Padding(
                  padding: const EdgeInsets.only(
                      top: Dimensions.paddingSizeSmall,
                      bottom: Dimensions.paddingSizeSmall),
                  child: Text('Do you want to close and exit app',
                      style: textRegular.copyWith(
                          color:
                              Theme.of(context).textTheme.bodyLarge?.color))),
              const SizedBox(height: Dimensions.paddingSizeDefault),
              Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: Dimensions.paddingSizeOverLarge),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                            child: CustomButton(
                          buttonText: 'Cancel',
                          backgroundColor: Theme.of(context)
                              .colorScheme
                              .tertiaryContainer
                              .withOpacity(.5),
                          textColor:
                              Theme.of(context).textTheme.bodyLarge?.color,
                          onTap: () => Navigator.pop(context),
                        )),
                        const SizedBox(
                          width: Dimensions.paddingSizeDefault,
                        ),
                        const Expanded(
                            child: CustomButton(
                                backgroundColor: yellow,
                                buttonText: 'Exit',
                                onTap: SystemNavigator.pop))
                      ]))
            ],
          ),
        ),
      );
}
