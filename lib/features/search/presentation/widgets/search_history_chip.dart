import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/styles.dart';
import '../manager/search_cubit.dart';

class SearchHistoryChip extends StatelessWidget {
  const SearchHistoryChip({super.key, required this.text, required this.onSearch});
  final Function(String) onSearch;

  final String text;

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: () => onSearch(text),
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: const BorderSide(color: Color(0xFFB2BACE))),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                text,
                style: textMedium.copyWith(
                  color: kTextDark,
                  fontSize: 14,
                ),
              ),
              const SizedBox(width: 8),
              InkWell(
                onTap: () {
                  context.read<SearchCubit>().removeHistoryItem(text);
                },
                borderRadius: BorderRadius.circular(10),
                child: const Padding(
                  padding: EdgeInsets.all(2),
                  child: Icon(
                    Icons.close,
                    size: 16,
                    color: kPrimaryBlue,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}
