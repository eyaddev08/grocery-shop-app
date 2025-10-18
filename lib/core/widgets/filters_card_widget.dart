import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class FiltersCardWidget extends StatelessWidget {
  const FiltersCardWidget({
    super.key,
    required this.filterName,
    required this.active,
    this.onTap,
    this.isLoading = false,
  });
  final String filterName;
  final bool active;
  final VoidCallback? onTap;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: Container(
          width: 80,
          height: 36,
          decoration: ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: const BorderSide(color: Color(0xFFB2BACE)),
            ),
          ),
        ),
      );
    }

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: ShapeDecoration(
          color: active ? const Color(0xFFF9B023) : Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: BorderSide(
                color:
                    active ? const Color(0xFFF9B023) : const Color(0xFFB2BACE),
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
                color:
                    active ? const Color(0xFFFAFAFC) : const Color(0xFF61697C),
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
}
