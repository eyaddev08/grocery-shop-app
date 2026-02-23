// // show anchored popup menu beside the tapped widget
// import 'package:flutter/material.dart';

// import '../../constants/app_colors.dart';
// import '../styles.dart';

// Future<void> showAddressMenu(BuildContext context, GlobalKey addressKey,
//     String selectedAddress, void Function(void Function() fn) setState) async {
//   final ctx = addressKey.currentContext;
//   if (ctx == null) return;
//   final renderBox = ctx.findRenderObject() as RenderBox;
//   final overlay = Overlay.of(context).context.findRenderObject() as RenderBox;
//   final position = RelativeRect.fromRect(
//       Rect.fromLTWH(
//           renderBox.localToGlobal(Offset.zero).dx,
//           renderBox.localToGlobal(Offset.zero).dy,
//           renderBox.size.width,
//           renderBox.size.height),
//       Offset.zero & overlay.size);

//   final options = [
//     'Green Way 3000, Sylhet',
//     'Downtown Market, Sylhet',
//     'Home, 12 Baker St',
//   ];

//   final selected = await showMenu<String>(
//     color: const Color(0xFF142F74),
//     context: context,
//     position: position,
//     items: options
//         .map((o) => PopupMenuItem<String>(
//               value: o,
//               child: Row(children: [
//                 Expanded(child: Text(o, style: textBold.copyWith(color: kLightGrayBg))),
//                 if (o == selectedAddress)
//                   const Icon(Icons.check, color: kYellow),
//               ]),
//             ))
//         .toList(),
//   );

//   if (selected != null) setState(() => selectedAddress = selected);
// }

// lib/core/utils/functions/show_address_menu.dart

import 'package:flutter/material.dart';
import '../../../features/checkout/domain/entities/address.dart';
import '../../constants/app_colors.dart';
import '../../utils/styles.dart';

Future<Address?> showAddressMenu(
  BuildContext context,
  GlobalKey addressKey,
  List<Address>? addresses, {
  bool isLoading = false,
  required VoidCallback onAddAddress,
}) async {
  final ctx = addressKey.currentContext;
  if (ctx == null) return null;

  final renderBox = ctx.findRenderObject() as RenderBox;
  final overlay = Overlay.of(context).context.findRenderObject() as RenderBox;

  final position = RelativeRect.fromRect(
    Rect.fromLTWH(
      renderBox.localToGlobal(Offset.zero).dx,
      renderBox.localToGlobal(Offset.zero).dy,
      renderBox.size.width,
      renderBox.size.height,
    ),
    Offset.zero & overlay.size,
  );

  // ===== 1) Loading state: show 3 shimmer placeholders (disabled)
  if (isLoading) {
    return showMenu<Address>(
      color: const Color(0xFF142F74),
      context: context,
      position: position,
      items: List.generate(
        3,
        (i) => PopupMenuItem<Address>(
          enabled: false,
          child: Row(
            children: [
              // small icon placeholder
              Container(
                width: 22,
                height: 22,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              const SizedBox(width: 10),
              // text placeholder
              Expanded(
                child: Container(
                  height: 14,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ===== 2) No addresses: show message + add button
  if (addresses == null || addresses.isEmpty) {
    return showMenu<Address>(
      color: const Color(0xFF142F74),
      context: context,
      position: position,
      items: [
        PopupMenuItem<Address>(
          enabled: false,
          child: Text(
            'No saved  addresses',
            style: titleRegular.copyWith(color: kLightGrayBg),
          ),
        ),
        PopupMenuItem<Address>(
          enabled: true,
          child: InkWell(
            onTap: () {
              // close the menu first then call handler
              Navigator.of(context).pop();
              onAddAddress();
            },
            child: Row(
              children: [
                const Icon(Icons.add_location_alt, color: kYellow),
                const SizedBox(width: 10),
                Text(
                  'Add a new address',
                  style: textBold.copyWith(color: kYellow),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // ===== 3) Show real addresses
  return showMenu<Address>(
    color: const Color(0xFF142F74),
    context: context,
    position: position,
    items: addresses
        .map((a) => PopupMenuItem<Address>(
              value: a,
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      (a.label.isNotEmpty && a.details.isNotEmpty
                          ? '${a.label}, ${a.details}'
                          : 'address'),
                      style: textBold.copyWith(color: kLightGrayBg),
                    ),
                  ),
                  if (a.isDefault == true)
                    const Icon(Icons.check, color: kYellow),
                ],
              ),
            ))
        .toList(),
  );
}
