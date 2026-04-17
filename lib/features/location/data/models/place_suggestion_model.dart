import 'package:grocery_shop_app/features/location/domain/entities/place_suggestion.dart';

/// Data model for Google Places autocomplete suggestion.
class PlaceSuggestionModel {

  const PlaceSuggestionModel({
    required this.placeId,
    required this.description,
  });

  factory PlaceSuggestionModel.fromJson(Map<String, dynamic> json) => PlaceSuggestionModel(
      placeId: json['place_id'] as String,
      description: json['description'] as String,
    );
  final String placeId;
  final String description;

  Map<String, dynamic> toJson() => {
        'place_id': placeId,
        'description': description,
      };

  PlaceSuggestion toEntity() => PlaceSuggestion(
      placeId: placeId,
      description: description,
    );
}


