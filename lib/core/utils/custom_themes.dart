import 'package:flutter/material.dart';
import 'package:grocery_shop_app/core/constants/app_colors.dart';

const titilliumRegular = TextStyle(
  fontFamily: 'Poppins',
  fontSize: 12,
);
const titleRegular = TextStyle(
  fontFamily: 'Poppins',
  fontWeight: FontWeight.w500,
  fontSize: 14,
  color: kMuted,
);
const titleHeader = TextStyle(
  fontFamily: 'Poppins',
  fontWeight: FontWeight.w600,
  fontSize: 16,
);
const titilliumSemiBold = TextStyle(
  fontFamily: 'Poppins',
  fontSize: 11,
  fontWeight: FontWeight.w600,
);

const titilliumBold = TextStyle(
  fontFamily: 'Poppins',
  fontSize: 14,
  fontWeight: FontWeight.w700,
);
const titilliumItalic = TextStyle(
  fontFamily: 'Poppins',
  fontSize: 14,
  fontStyle: FontStyle.italic,
);

const textRegular = TextStyle(
  fontFamily: 'Poppins',
  fontWeight: FontWeight.w300,
  fontSize: 14,
);

const textMedium = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 14,
    color: kTextDark,
    fontWeight: FontWeight.w500);
const textBold = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: kTextDark);

const robotoBold = TextStyle(
  fontFamily: 'Poppins',
  fontSize: 14,
  fontWeight: FontWeight.w700,
);


// class ThemeShadow {
//   static List <BoxShadow> getShadow(BuildContext context) {
//     List<BoxShadow> boxShadow =  [BoxShadow(color: Provider.of<ThemeController>(context, listen: false).darkTheme? Colors.black26:
//     Theme.of(context).primaryColor.withOpacity(.075), blurRadius: 5,spreadRadius: 1,offset: const Offset(1,1))];
//     return boxShadow;
//   }
// }