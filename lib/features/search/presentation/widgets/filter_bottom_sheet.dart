import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/styles.dart';
import '../../../../core/widgets/custom_button_widget.dart';
import '../../domain/entities/search_result.dart';
import 'brands_checklist.dart';
import 'categories_checklist.dart';
import 'custom_outlined_button.dart';

class FilterBottomSheet extends StatefulWidget {
  final Facets facets;
  final Map<String, dynamic> currentFilters;
  final ValueChanged<Map<String, dynamic>> onApply;

  const FilterBottomSheet({
    super.key,
    required this.facets,
    required this.currentFilters,
    required this.onApply,
  });

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  // Local state for filters
  late Map<String, dynamic> _filters;

  @override
  void initState() {
    super.initState();
    _filters = Map.from(widget.currentFilters);
  }

  @override
  Widget build(BuildContext context) => DraggableScrollableSheet(
        initialChildSize: 0.85,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        builder: (context, scrollController) => DecoratedBox(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            children: [
              // Handle
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Text('Filter',
                    style: textBold.copyWith(
                        fontSize: 18, fontWeight: FontWeight.w600)),
              ),
              const Divider(color: kMutedGray, height: 1),

              Expanded(
                child: ListView(
                  controller: scrollController,
                  padding: const EdgeInsets.only(bottom: 20),
                  children: [
                    const SizedBox(height: 16),

                    // Categories
                    CategoriesChecklist(
                      categories: widget.facets.categories,
                      selectedIds: _parseCategoryIds(_filters['category_id']),
                      onChanged: (ids) {
                        setState(() {
                          if (ids.isEmpty) {
                            _filters.remove('category_id');
                          } else if (ids.length == 1) {
                            _filters['category_id'] = ids.first;
                          } else {
                            if (ids.isNotEmpty) {
                              _filters['category_id'] = ids.last;
                            }
                          }
                        });
                      },
                    ),

                    const SizedBox(height: 16),

                    const Divider(height: 32),

                    // Brands
                    BrandsChecklist(
                      brands: widget.facets.brands,
                      selectedBrand: _filters['brand']?.toString(),
                      onChanged: (brand) {
                        setState(() {
                          if (brand == null) {
                            _filters.remove('brand');
                          } else {
                            _filters['brand'] = brand;
                          }
                        });
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Expanded(child: CustomOutlinedButton(
                      onPressed: () {
                        // Clear all local filters
                        setState(() {
                          _filters.clear();
                        });
                      },
                    )),
                    const SizedBox(width: 12),
                    Expanded(
                      child: CustomButton(
                        onPressed: () {
                          widget.onApply(_filters);
                          Navigator.pop(context);
                        },
                        buttonText: 'Apply',
                        buttonHeight: 48,
                        isBorder: true,
                        radius: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );

  Set<int> _parseCategoryIds(dynamic value) {
    if (value == null) return {};
    if (value is int) return {value};
    return {};
  }
}
