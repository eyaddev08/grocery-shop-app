// Simple bottom sheet to pick within time
import 'package:flutter/material.dart';

import '../../../../../core/constants/app_constants.dart';

class WithinPicker extends StatelessWidget {
  const WithinPicker({super.key, required this.selected});
  final String selected;

  @override
  Widget build(BuildContext context) {
    final options = ['30 Mins', '1 Hour', '2 Hours', 'Same Day'];
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: options
            .map((o) => ListTile(
                  title: Text(o),
                  trailing: o == selected
                      ? const Icon(Icons.check, color: yellow)
                      : null,
                  onTap: () => Navigator.of(context).pop(o),
                ))
            .toList(),
      ),
    );
  }
}
