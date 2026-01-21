import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/images.dart';
import '../../../../core/utils/styles.dart';
import '../../../../core/widgets/custom_asset_image_widget.dart';

class AppSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onSearch;
  final VoidCallback? onClear;
  final bool autoFocus;

  const AppSearchBar({
    super.key,
    required this.controller,
    this.hintText = 'Search',
    this.onChanged,
    this.onSearch,
    this.onClear,
    this.autoFocus = false,
  });

  @override
  Widget build(BuildContext context) => Row(children: [
        Expanded(
          child: Container(
            height: 54,
            decoration: BoxDecoration(
              color: kSearchBlue,
              borderRadius: BorderRadius.circular(28),
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.03),
                    blurRadius: 6,
                    offset: const Offset(0, 2)),
              ],
            ),
            child: Row(
              children: [
                const SizedBox(width: 12),
                Expanded(
                  child: TextField(
                    controller: controller,
                    autofocus: autoFocus,
                    onChanged: onChanged,
                    textInputAction: TextInputAction.search,
                    onSubmitted: (_) => onSearch?.call(),
                    decoration: InputDecoration(
                      hintText: hintText,
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      filled: true,
                      fillColor: Colors.transparent,
                      isCollapsed: true,
                      hintStyle: textMedium.copyWith(
                          fontSize: 16, color: const Color(0xFF7B7B8A)),
                    ),
                  ),
                ),
                ValueListenableBuilder<TextEditingValue>(
                  valueListenable: controller,
                  builder: (context, value, child) {
                    if (value.text.isNotEmpty) {
                      return IconButton(
                        icon: const Icon(Icons.close,
                            color: kAccentYellow, size: 24),
                        onPressed: onClear,
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: GestureDetector(
                    onTap: onSearch,
                    child: Container(
                      width: 44,
                      height: 44,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: kPrimaryBlue,
                        borderRadius: BorderRadius.circular(28),
                      ),
                      child: const CustomAssetImageWidget(
                        Images.searchIcon,
                        color: Colors.white60,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ]);
}
