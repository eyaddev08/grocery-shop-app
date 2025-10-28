// show anchored popup menu beside the tapped widget
import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';

Future<void> showAddressMenu(BuildContext context, GlobalKey addressKey,
    String selectedAddress, void Function(void Function() fn) setState) async {
  final ctx = addressKey.currentContext;
  if (ctx == null) return;
  final renderBox = ctx.findRenderObject() as RenderBox;
  final overlay = Overlay.of(context).context.findRenderObject() as RenderBox;
  final position = RelativeRect.fromRect(
      Rect.fromLTWH(
          renderBox.localToGlobal(Offset.zero).dx,
          renderBox.localToGlobal(Offset.zero).dy,
          renderBox.size.width,
          renderBox.size.height),
      Offset.zero & overlay.size);

  final options = [
    'Green Way 3000, Sylhet',
    'Downtown Market, Sylhet',
    'Home, 12 Baker St',
  ];

  final selected = await showMenu<String>(
    color: const Color(0xFF142F74),
    context: context,
    position: position,
    items: options
        .map((o) => PopupMenuItem<String>(
              value: o,
              child: Row(children: [
                Expanded(child: Text(o)),
                if (o == selectedAddress)
                  const Icon(Icons.check, color: kYellow),
              ]),
            ))
        .toList(),
  );

  if (selected != null) setState(() => selectedAddress = selected);
}
