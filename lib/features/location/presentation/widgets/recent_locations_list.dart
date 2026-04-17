import 'package:flutter/material.dart';
import 'package:grocery_shop_app/core/constants/app_colors.dart';
import 'package:grocery_shop_app/core/utils/styles.dart';
import 'package:grocery_shop_app/features/location/domain/entities/location_entity.dart';

class RecentLocationsList extends StatelessWidget {
  const RecentLocationsList({
    super.key,
    required this.locations,
    required this.onTapLocation,
    required this.onClear,
  });

  final List<LocationEntity> locations;
  final ValueChanged<LocationEntity> onTapLocation;
  final VoidCallback onClear;

  @override
  Widget build(BuildContext context) {
    if (locations.isEmpty) {
      return const SizedBox.shrink();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Recent locations',
              style: textBold,
            ),
            TextButton(
              onPressed: onClear,
              child: Text(
                'Clear',
                style: textBold.copyWith(color: errorColor),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: locations.length,
          separatorBuilder: (_, __) =>
              const Divider(color: kMutedGray, height: 1),
          itemBuilder: (context, index) {
            final loc = locations[index];
            final title = loc.formattedAddress ??
                '${loc.latitude.toStringAsFixed(5)}, ${loc.longitude.toStringAsFixed(5)}';
            debugPrint(
              title.toString().replaceAll('Exception: ', ''),
            );
            return ListTile(
              dense: true,
              title: Text(
                title,
                style: textBold.copyWith(color: kAccentYellow),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              subtitle: Text(
                loc.pickedAt.toLocal().toString(),
                style: textMedium.copyWith(
                    fontSize: 12, color: kMuted, fontWeight: FontWeight.normal),
              ),
              onTap: () => onTapLocation(loc),
            );
          },
        ),
      ],
    );
  }
}
