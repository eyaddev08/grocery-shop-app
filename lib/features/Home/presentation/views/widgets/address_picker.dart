// Simple bottom sheet to pick an address
import 'package:flutter/material.dart';

import '../../../../../core/constants/app_constants.dart';

class AddressPicker extends StatelessWidget {
  const AddressPicker({super.key, required this.selected});
  final String selected;

  @override
  Widget build(BuildContext context) {
    final options = [
      'Green Way 3000, Sylhet',
      'Downtown Market, Sylhet',
      'Home, 12 Baker St',
    ];
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
