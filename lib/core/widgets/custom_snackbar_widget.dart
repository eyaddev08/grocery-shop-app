import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:grocery_shop_app/core/constants/app_colors.dart';

import '../utils/dimensions.dart';
import 'custom_toast_widget.dart';

enum SnackBarType {
  error,
  warning,
  success,
}

void showCustomSnackBarWidget(String? message, BuildContext? context,
    {bool isError = true,
    bool isToaster = false,
    SnackBarType sanckBarType = SnackBarType.success}) {
  final scaffold = ScaffoldMessenger.of(context!);
  scaffold.showSnackBar(
    SnackBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      
      padding: EdgeInsets.zero,
      content: CustomToast(text: message ?? '', sanckBarType: sanckBarType),
      duration: const Duration(seconds: 2),
      behavior: SnackBarBehavior.floating,
    ),
  );
}

void showCustomToast(
    {bool isSuccess = true,
    required String message,
    required BuildContext context}) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: isSuccess ? kPrimaryBlue : errorColor,
      textColor: Colors.white,
      fontSize: Dimensions.fontSizeDefault);
}
