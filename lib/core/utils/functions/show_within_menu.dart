 import 'package:flutter/material.dart';

import '../../constants/app_constants.dart';

Future<void> showWithinMenu(BuildContext context,GlobalKey withinKey, String selectedWithin, void Function(void Function() fn) setState) async {
    final ctx = withinKey.currentContext;
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

    final options = ['30 Mins', '1 Hour', '2 Hours', 'Same Day'];

    final selected = await showMenu<String>(
      color: const Color(0xFF142F74),
      context: context,
      position: position,
      items: options
          .map((o) => PopupMenuItem<String>(
                value: o,
                child: Row(children: [
                  Expanded(child: Text(o)),
                  if (o == selectedWithin)
                    const Icon(Icons.check, color: yellow),
                ]),
              ))
          .toList(),
    );

    if (selected != null) setState(() => selectedWithin = selected);
  }

 