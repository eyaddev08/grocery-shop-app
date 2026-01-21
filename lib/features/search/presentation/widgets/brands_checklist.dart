import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/styles.dart';
import '../../domain/entities/search_result.dart'; // For FacetItem

class BrandsChecklist extends StatefulWidget {
  final List<FacetItem> brands;
  final String?
      selectedBrand; 
  final ValueChanged<String?> onChanged;

  const BrandsChecklist({
    super.key,
    required this.brands,
    this.selectedBrand,
    required this.onChanged,
  });

  @override
  State<BrandsChecklist> createState() => _BrandsChecklistState();
}

class _BrandsChecklistState extends State<BrandsChecklist> {
  String? _selected;

  @override
  void initState() {
    super.initState();
    _selected = widget.selectedBrand;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.brands.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            'Brands',
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
          itemCount: widget.brands.length,
          itemBuilder: (context, index) {
            final brand = widget.brands[index];
            final isSelected = _selected == brand.name;

            return CheckboxListTile(
              title: Text('${brand.name} (${brand.count})',
                  style: textMedium.copyWith(fontSize: 14, color: kMuted)),
              value: isSelected,
              checkColor: kBeige,
              activeColor: const Color(0xFF0A5ED3),
              controlAffinity: ListTileControlAffinity.leading,
              contentPadding: const EdgeInsets.symmetric(horizontal: 4),
              onChanged: (val) {
                setState(() {
                  if (val == true) {
                    _selected = brand.name;
                  } else {
                    _selected = null;
                  }
                  widget.onChanged(_selected);
                });
              },
            );
          },
        ),
      ],
    );
  }
}
