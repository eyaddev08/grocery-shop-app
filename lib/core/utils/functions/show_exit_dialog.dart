import 'package:flutter/material.dart';
import '../../widgets/app_exit_card_widget.dart';

Future<bool> showExitDialog(BuildContext context) async {
  final shouldExit = await showGeneralDialog<bool>(
    context: context,
    barrierDismissible: true,
    barrierLabel: 'Dismiss',
    transitionDuration: const Duration(milliseconds: 200),
    pageBuilder: (ctx, anim1, anim2) => const Center(child:  AppExitCard()),
  );

  return shouldExit ?? false;
}
