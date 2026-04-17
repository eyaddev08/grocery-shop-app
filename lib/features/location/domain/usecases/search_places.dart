import 'package:dartz/dartz.dart';
import 'package:grocery_shop_app/core/error/failure.dart';
import 'package:grocery_shop_app/features/location/domain/entities/place_suggestion.dart';
import 'package:grocery_shop_app/features/location/domain/repositories/location_repository.dart';

/// Use case: search for places using Google Places Autocomplete API.
class SearchPlacesUseCase {

  SearchPlacesUseCase(this.repository);
  final LocationRepository repository;

  Future<Either<Failure, List<PlaceSuggestion>>> call(String query) {
    if (query.trim().isEmpty) {
      // Short‑circuit empty queries with an empty list.
      return Future.value(const Right<Failure, List<PlaceSuggestion>>([]));
    }
    return repository.searchPlaces(query);
  }
}


