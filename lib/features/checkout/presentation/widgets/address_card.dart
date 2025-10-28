import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../domain/entities/address.dart';

class AddressCard extends StatelessWidget {
  const AddressCard(
      {super.key,
      required this.address,
      required this.onSelect,
      required this.onEdit,
      required this.onDelete});
  final Address address;
  final VoidCallback onSelect;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: onSelect,
        child: Container(
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.all(12),
          height: 96,
          decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
              side: BorderSide(
                  color: address.isDefault
                      ? kAccentYellow
                      : const Color(0x60D8D8D8),
                  width: address.isDefault ? 2 : 1),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(address.label,
                        style: const TextStyle(
                            fontSize: 14, color: Color(0xFF1E222B))),
                    const SizedBox(height: 16),
                    Text(address.details,
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w600)),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      InkWell(
                          onTap: onEdit,
                          child: const SizedBox(
                            width: 49,
                            height: 16,
                            child: Text(
                              'Edit',
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                color: Color(0xFF2A4BA0),
                                fontSize: 12,
                                fontFamily: 'Manrope',
                                fontWeight: FontWeight.w500,
                                height: 1.33,
                                letterSpacing: 0.24,
                              ),
                            ),
                          )),
                      const SizedBox(width: 12),
                      InkWell(
                        borderRadius: BorderRadius.circular(12),
                        onTap: onDelete,
                        child: SizedBox(
                          width: 24,
                          height: 24,
                          child: Image.asset('assets/images/delete.png',
                              height: 18, width: 18),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Container(
                    width: 22,
                    height: 22,
                    decoration: BoxDecoration(
                      color: address.isDefault
                          ? kAccentYellow
                          : Colors.transparent,
                      shape: BoxShape.circle,
                      border: Border.all(
                          color: address.isDefault
                              ? kAccentYellow
                              : Colors.transparent),
                    ),
                    child: address.isDefault
                        ? const Icon(Icons.check, size: 14, color: Colors.white)
                        : const SizedBox.shrink(),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
}
