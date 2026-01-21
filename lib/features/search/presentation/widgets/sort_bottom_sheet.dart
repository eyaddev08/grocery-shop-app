import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/styles.dart';
import '../../../../core/widgets/custom_button_widget.dart';
import 'custom_outlined_button.dart';

class SortBottomSheet extends StatefulWidget {
  final String currentSort;
  final RangeValues currentPriceRange;
  final RangeValues maxPriceLimits;
  // ignore: inference_failure_on_function_return_type
  final Function(String sort, RangeValues priceRange) onApply;

  const SortBottomSheet({
    super.key,
    required this.currentSort,
    required this.currentPriceRange,
    required this.maxPriceLimits,
    required this.onApply,
  });

  @override
  State<SortBottomSheet> createState() => _SortBottomSheetState();
}

class _SortBottomSheetState extends State<SortBottomSheet> {
  late String _tempSort;
  late RangeValues _tempPriceRange;
  late double _minLimit;
  late double _maxLimit;

  @override
  void initState() {
    super.initState();
    _tempSort = widget.currentSort;
    _tempPriceRange = widget.currentPriceRange;
    _minLimit = widget.maxPriceLimits.start;
    _maxLimit = widget.maxPriceLimits.end;

    // Validate range
    if (_maxLimit <= _minLimit) _maxLimit = _minLimit + 100;

    final start = _tempPriceRange.start.clamp(_minLimit, _maxLimit);
    final end = _tempPriceRange.end.clamp(_minLimit, _maxLimit);
    _tempPriceRange =
        RangeValues(start <= end ? start : start, end >= start ? end : start);
  }

  @override
  Widget build(BuildContext context) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        padding: const EdgeInsets.only(bottom: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Price Range',
                      style: textBold.copyWith(fontSize: 16, color: kTextDark)),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('\$${_tempPriceRange.start.toStringAsFixed(2)}',
                          style: textMedium),
                      const Text(' - ', style: textMedium),
                      Text('\$${_tempPriceRange.end.toStringAsFixed(2)}',
                          style: textMedium),
                    ],
                  ),
                  RangeSlider(
                    values: _tempPriceRange,
                    min: _minLimit,
                    max: _maxLimit,
                    activeColor: kPrimaryBlue,
                    inactiveColor: const Color(0xFFE7E9F0),
                    onChanged: (values) {
                      setState(() {
                        _tempPriceRange = values;
                      });
                    },
                  ),
                ],
              ),
            ),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Divider(color: kMutedGray, height: 1),
            ),

            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text('Sort',
                  style: textBold.copyWith(fontSize: 18, color: kPrimaryBlue)),
            ),
            const SizedBox(height: 8),

            _buildRadioOption('Latest Products', 'relevance'),
            _buildRadioOption('Alphabetically A-Z', 'name_asc'),
            _buildRadioOption('Alphabetically Z-A', 'name_desc'),
            _buildRadioOption('Low to high price', 'price_asc'),
            _buildRadioOption('High to low price', 'price_desc'),

            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Expanded(
                    child: CustomOutlinedButton(onPressed: () {
                      setState(() {
                        _tempSort = 'relevance';
                        _tempPriceRange =
                            widget.maxPriceLimits; // Reset to full range
                      });
                    }),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: CustomButton(
                      onTap: () {
                        widget.onApply(_tempSort, _tempPriceRange);
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
      );

  Widget _buildRadioOption(String title, String value) => RadioListTile<String>(
        title: Text(title,
            style: textRegular.copyWith(fontSize: 16, color: kTextDark)),
        value: value,
        groupValue: _tempSort,
        activeColor: const Color(0xFF0A5ED3),
        contentPadding: const EdgeInsets.symmetric(horizontal: 8),
        onChanged: (val) {
          if (val != null) {
            setState(() => _tempSort = val);
          }
        },
      );
}
