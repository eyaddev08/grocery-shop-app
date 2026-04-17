import 'package:flutter/material.dart';
import 'package:grocery_shop_app/core/utils/styles.dart';
import 'package:grocery_shop_app/features/location/domain/entities/place_suggestion.dart';

class PlaceSuggestionTile extends StatelessWidget {
  const PlaceSuggestionTile({
    super.key,
    required this.suggestion,
    this.onTap,
  });

  final PlaceSuggestion suggestion;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) => ListTile(
        title: Text(
          suggestion.description,
          style: textBold,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        onTap: onTap,
      );
}
