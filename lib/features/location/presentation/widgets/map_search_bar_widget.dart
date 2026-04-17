import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:grocery_shop_app/core/constants/app_colors.dart';
import 'package:grocery_shop_app/core/utils/styles.dart';

import '../../../../core/utils/images.dart';
import '../../../../core/widgets/custom_asset_image_widget.dart';
import '../../domain/entities/place_suggestion.dart';
import '../manager/location_cubit.dart';
import 'place_suggestion_tile.dart';

class MapSearchBarWidget extends StatelessWidget {
  const MapSearchBarWidget({super.key, required this.onSubmitted});
  final VoidCallback onSubmitted;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<LocationCubit>();

    return Material(
      elevation: 4,
      color: kPrimaryBlue,
      borderRadius: BorderRadius.circular(8),
      child: TypeAheadField<PlaceSuggestion>(
        loadingBuilder: (context) => const Padding(
          padding: EdgeInsets.symmetric(vertical: 24, horizontal: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(child: CircularProgressIndicator(color: kAccentYellow)),
            ],
          ),
        ),
        suggestionsCallback: (pattern) async {
          if (pattern.trim().isEmpty) {
            return <PlaceSuggestion>[];
          }
          return await cubit.getSearchSuggestions(pattern);
        },
        emptyBuilder: (context) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Center(
                child: Icon(
                  Icons.location_off_outlined,
                  size: 48,
                  color: kAccentYellow,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'No results found for your search.\nPlease try another term.',
                textAlign: TextAlign.center,
                style: textMedium.copyWith(color: kMutedGray),
              ),
            ],
          ),
        ),
        builder: (context, controller, focusNode) => TextField(
          controller: controller,
          focusNode: focusNode,
          cursorColor: kAccentYellow,
          style: textBold.copyWith(fontSize: 16, color: kMutedGray),
          decoration: InputDecoration(
            hintText: 'Search place',
            prefixIcon: const SizedBox(
              height: 18,
              width: 18,
              child: Padding(
                padding: EdgeInsets.all(12),
                child: CustomAssetImageWidget(
                  Images.searchIcon,
                  color: Colors.white60,
                ),
              ),
            ),
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            filled: true,
            fillColor: Colors.transparent,
            isCollapsed: true,
            hintStyle: textMedium.copyWith(fontSize: 16, color: kMutedGray),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          ),
        ),
         errorBuilder: (context, error) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Center(
                child: Icon(
                  Icons.error_outline,
                  size: 48,
                  color: Colors.red,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Error searching places: ${error.toString()}',
                textAlign: TextAlign.center,
                style: textMedium.copyWith(color: kMutedGray),
              ),
            ],
          ),
        ),
        itemBuilder: (context, suggestion) => PlaceSuggestionTile(
          suggestion: suggestion,
        ),
        onSelected: (suggestion) {
          cubit.selectSuggestion(suggestion.placeId);
          onSubmitted();
        },
      ),
    );
  }
}
