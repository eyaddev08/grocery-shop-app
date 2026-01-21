import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/styles.dart';
import '../../domain/entities/search_result.dart'; 

class CategoriesChecklist extends StatefulWidget {
  final List<FacetItem> categories;
  final Set<int> selectedIds; // Assuming category IDs are stored as ints
  final ValueChanged<Set<int>> onChanged;

  const CategoriesChecklist({
    super.key,
    required this.categories,
    required this.selectedIds,
    required this.onChanged,
  });

  @override
  State<CategoriesChecklist> createState() => _CategoriesChecklistState();
}

class _CategoriesChecklistState extends State<CategoriesChecklist> {
  late Set<int> _currentSelection;

  @override
  void initState() {
    super.initState();
    _currentSelection = Set.from(widget.selectedIds);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.categories.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            'Categories',
            style: textBold.copyWith(fontSize: 16, color: kTextDark),
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Divider(color: kMutedGray, height: 1),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: widget.categories.length,
          itemBuilder: (context, index) {
            final cat = widget.categories[index];
            final catId = int.tryParse(cat.id) ?? -1;
            if (catId == -1) return const SizedBox.shrink();

            final isSelected = _currentSelection.contains(catId);
            return CheckboxListTile(
              title: Text('${cat.name} (${cat.count})',
                  style: textMedium.copyWith(fontSize: 14, color: kMuted)),
              value: isSelected,
              activeColor: const Color(0xFF0A5ED3),
              controlAffinity: ListTileControlAffinity.leading,
              contentPadding: const EdgeInsets.symmetric(horizontal: 4),
              onChanged: (val) {
                setState(() {
                  if (val == true) {
                    _currentSelection.add(catId);
                  } else {
                    _currentSelection.remove(catId);
                  }
                  widget.onChanged(_currentSelection);
                });
              },
            );
          },
        ),
      ],
    );
  }
}
