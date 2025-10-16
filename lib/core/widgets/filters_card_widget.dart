import 'package:flutter/material.dart';

class FiltersCardWidget extends StatelessWidget {
  const FiltersCardWidget({
    super.key,
    required this.filterName,
    required this.active,
    this.onTap,
  });
  final String filterName;
  final bool active;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: ShapeDecoration(
            color: active ? const Color(0xFFF9B023) : Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: BorderSide(
                  color: active
                      ? const Color(0xFFF9B023)
                      : const Color(0xFFB2BACE),
                )),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                filterName,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: active
                      ? const Color(0xFFFAFAFC)
                      : const Color(0xFF1E222B),
                  fontSize: 14,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                  height: 1.43,
                ),
              ),
            ],
          ),
        ),
      );
}
