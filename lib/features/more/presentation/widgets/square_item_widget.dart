import 'package:flutter/material.dart';
import 'package:grocery_shop_app/core/constants/app_colors.dart';

import '../../../../core/helpers/create_slide_fade_route.dart';
import '../../../../core/helpers/price_converter.dart';
import '../../../../core/utils/styles.dart';
import '../../../../core/utils/dimensions.dart';

class SquareButtonWidget extends StatelessWidget {
  const SquareButtonWidget(
      {super.key,
      required this.image,
      required this.title,
      required this.navigateTo,
      required this.count,
      required this.hasCount,
      this.isWallet = false,
      this.balance,
      this.subTitle,
      this.isLoyalty = false});
  final String image;
  final String? title;
  final Widget navigateTo;
  final int count;
  final bool hasCount;
  final bool isWallet;
  final double? balance;
  final bool isLoyalty;
  final String? subTitle;

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: () =>
            Navigator.push<void>(context, createSlideFadeRoute(navigateTo)),
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: Container(
                width: 120,
                height: 90,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: kPrimaryBlue),
                child: Stack(children: [
                  Positioned(
                      top: -80,
                      left: -10,
                      right: -10,
                      child: Container(
                          height: 120,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: kAccentYellow.withOpacity(.07),
                                  width: 15),
                              borderRadius: BorderRadius.circular(100)))),
                  if (isWallet)
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: SizedBox(
                          width: 30,
                          height: 30,
                          child: Image.asset(image, color: kAccentYellow)),
                    )
                  else
                    Center(
                        child: Padding(
                            padding: const EdgeInsets.all(
                                Dimensions.paddingSizeLarge),
                            child: Image.asset(image, color: kAccentYellow))),
                  if (isWallet)
                    Positioned(
                        right: 10,
                        bottom: 10,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                subTitle ?? '',
                                style:
                                    textRegular.copyWith(color: kAccentYellow),
                              ),
                              if (isLoyalty)
                                Text(
                                    balance != null
                                        ? balance!.toStringAsFixed(0)
                                        : '0',
                                    style: textMedium.copyWith(
                                        color: kAccentYellow))
                              else
                                Text(
                                    balance != null
                                        ? PriceConverter.convertPrice(
                                            context, balance)
                                        : '0',
                                    style: textMedium.copyWith(
                                        color: kAccentYellow))
                            ])),
                  if (hasCount)
                    Positioned(
                        top: 5,
                        right: 5,
                        child: CircleAvatar(
                            radius: 10,
                            backgroundColor: kAccentYellow,
                            child: Text(count.toString(),
                                style: titilliumSemiBold.copyWith(
                                    color: kPrimaryBlue,
                                    fontSize: Dimensions.fontSizeExtraSmall))))
                  else
                    const SizedBox(),
                ])),
          ),
          Text(title ?? '',
              maxLines: 1,
              overflow: TextOverflow.clip,
              style: titilliumRegular.copyWith(
                  fontSize: Dimensions.fontSizeDefault,
                  color: Theme.of(context).textTheme.bodyLarge?.color)),
        ]),
      );
}
