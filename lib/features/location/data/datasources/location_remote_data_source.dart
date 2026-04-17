import 'package:dio/dio.dart';
import 'package:grocery_shop_app/features/location/data/models/place_details_model.dart';
import 'package:grocery_shop_app/features/location/data/models/place_suggestion_model.dart';

/// Remote data source that talks to Google Places & Geocoding APIs.
///
/// NOTE: No API keys are hard‑coded here. The key is read from
/// `--dart-define=GOOGLE_MAPS_API_KEY=...` at build time.
abstract class LocationRemoteDataSource {
  Future<List<PlaceSuggestionModel>> searchPlaces(String query);

  Future<PlaceDetailsModel> getPlaceDetails(String placeId);

  /// Reverse geocode: coordinates -> address components.
  Future<PlaceDetailsModel> reverseGeocode({
    required double latitude,
    required double longitude,
  });
}

class LocationRemoteDataSourceImpl implements LocationRemoteDataSource {
  LocationRemoteDataSourceImpl(this._dio);

  final Dio _dio;

  // Read from compile‑time environment (flutter run --dart-define=...).
  static const String _googleApiKey =
      String.fromEnvironment('GOOGLE_MAPS_API_KEY');

  static const String _placesBaseUrl =
      'https://maps.googleapis.com/maps/api/place';
  static const String _geocodeUrl =
      'https://maps.googleapis.com/maps/api/geocode/json';

  Map<String, dynamic> get _commonParams => <String, dynamic>{
        'key': _googleApiKey,
        'language': 'en',
      };

  @override
  Future<List<PlaceSuggestionModel>> searchPlaces(String query) async {
    if (_googleApiKey.isEmpty) {
      throw DioException(
        requestOptions:
            RequestOptions(path: '$_placesBaseUrl/autocomplete/json'),
        message:
            'Google Maps API key not configured. Please set GOOGLE_MAPS_API_KEY using --dart-define.',
      );
    }
    final response = await _dio.get<Map<String, dynamic>>(
      '$_placesBaseUrl/autocomplete/json',
      queryParameters: <String, dynamic>{
        ..._commonParams,
        'input': query,
        'types': 'geocode',
      },
    );

    final data = response.data ?? <String, dynamic>{};
    final status = data['status'] as String? ?? 'UNKNOWN_ERROR';
    if (status != 'OK' && status != 'ZERO_RESULTS') {
      throw DioException(
        requestOptions: response.requestOptions,
        error: 'Places Autocomplete failed: $status',
      );
    }

    final predictions = (data['predictions'] as List<dynamic>? ?? <dynamic>[])
        .cast<Map<String, dynamic>>();

    return predictions
        .map<PlaceSuggestionModel>(
            (json) => PlaceSuggestionModel.fromJson(json))
        .toList();
  }

  @override
  Future<PlaceDetailsModel> getPlaceDetails(String placeId) async {
    if (_googleApiKey.isEmpty) {
      throw DioException(
        requestOptions: RequestOptions(path: '$_placesBaseUrl/details/json'),
        message:
            'Google Maps API key not configured. Please set GOOGLE_MAPS_API_KEY using --dart-define.',
      );
    }
    final response = await _dio.get<Map<String, dynamic>>(
      '$_placesBaseUrl/details/json',
      queryParameters: <String, dynamic>{
        ..._commonParams,
        'place_id': placeId,
        'fields':
            'place_id,geometry/location,formatted_address,address_components',
      },
    );

    final data = response.data ?? <String, dynamic>{};
    final status = data['status'] as String? ?? 'UNKNOWN_ERROR';
    if (status != 'OK') {
      throw DioException(
        requestOptions: response.requestOptions,
        error: 'Place Details failed: $status',
      );
    }

    return PlaceDetailsModel.fromJson(data);
  }

  @override
  Future<PlaceDetailsModel> reverseGeocode({
    required double latitude,
    required double longitude,
  }) async {
    if (_googleApiKey.isEmpty) {
      throw DioException(
        requestOptions: RequestOptions(path: _geocodeUrl),
        message:
            'Google Maps API key not configured. Please set GOOGLE_MAPS_API_KEY using --dart-define.',
      );
    }
    final response = await _dio.get<Map<String, dynamic>>(
      _geocodeUrl,
      queryParameters: <String, dynamic>{
        ..._commonParams,
        'latlng': '$latitude,$longitude',
      },
    );

    final data = response.data ?? <String, dynamic>{};
    final status = data['status'] as String? ?? 'UNKNOWN_ERROR';
    if (status != 'OK') {
      throw DioException(
        requestOptions: response.requestOptions,
        error: 'Reverse geocoding failed: $status',
      );
    }

    // Geocoding API shape is slightly different from place details.
    final results =
        (data['results'] as List<dynamic>).cast<Map<String, dynamic>>();
    final first = results.first;
    final geometry = first['geometry'] as Map<String, dynamic>;
    final locationJson = geometry['location'] as Map<String, dynamic>;

    final components =
        (first['address_components'] as List<dynamic>? ?? <dynamic>[])
            .cast<Map<String, dynamic>>();

    String? _findType(String type) {
      final match = components.firstWhere(
        (c) => (c['types'] as List).contains(type),
        orElse: () => <String, dynamic>{},
      );
      if (match.isEmpty) return null;
      return match['long_name'] as String?;
    }

    final placeJson = <String, dynamic>{
      'result': <String, dynamic>{
        'place_id': first['place_id'] ?? '${latitude}_$longitude',
        'formatted_address': first['formatted_address'],
        'geometry': <String, dynamic>{'location': locationJson},
        'address_components': components,
      },
      'status': status,
    };

    return PlaceDetailsModel.fromJson(placeJson);
  }
}
