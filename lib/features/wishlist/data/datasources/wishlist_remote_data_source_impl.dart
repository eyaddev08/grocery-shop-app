import 'package:dio/dio.dart';
import '../../../../core/error/exception.dart';
import '../models/wishlist_product_model.dart';
import 'wishlist_remote_data_source.dart';

class WishlistRemoteDataSourceImpl implements WishlistRemoteDataSource {
  WishlistRemoteDataSourceImpl({required this.client, this.baseUrl = ''});
  final Dio client;
  final String baseUrl;

  Map<String, dynamic>? _toMap(dynamic data) {
    if (data == null) return null;
    if (data is Map<String, dynamic>) return data;
    if (data is Map) return Map<String, dynamic>.from(data);
    return null;
  }

  @override
  Future<List<WishlistProductModel>> getWishlist() async {
    try {
      final response = await client.get<dynamic>(
        '$baseUrl/api/wishlist',
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );

      if (response.statusCode != 200) {
        throw ServerException('Failed to load wishlist');
      }

      final map = _toMap(response.data);
      if (map == null) {
        throw ServerException('Invalid response format');
      }

      final raw =
          map['data'] ?? map['products'] ?? map['wishlist'] ?? <dynamic>[];
      if (raw is List) {
        return raw
            .map<WishlistProductModel?>((e) {
              if (e is Map) {
                return WishlistProductModel.fromJson(
                  Map<String, dynamic>.from(e),
                );
              }
              return null;
            })
            .whereType<WishlistProductModel>()
            .toList();
      }

      return <WishlistProductModel>[];
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.sendTimeout) {
        throw NetworkException('Connection timeout');
      }
      if (e.response?.statusCode == 404) {
        return <WishlistProductModel>[];
      }
      throw ServerException('Failed to load wishlist: ${e.message}');
    } catch (e) {
      if (e is ServerException || e is NetworkException) {
        rethrow;
      }
      throw ServerException('Unexpected error: ${e.toString()}');
    }
  }

  @override
  Future<WishlistProductModel> addToWishlist(
      WishlistProductModel product) async {
    try {
      final response = await client.post<dynamic>(
        '$baseUrl/api/wishlist',
        data: product.toJson(),
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw ServerException('Failed to add product to wishlist');
      }

      final map = _toMap(response.data);
      if (map == null) {
        throw ServerException('Invalid response format');
      }

      final productData = map['data'] ?? map['product'] ?? map;
      if (productData is Map) {
        return WishlistProductModel.fromJson(
          Map<String, dynamic>.from(productData),
        );
      }

      // إذا لم يكن هناك بيانات في الاستجابة، نعيد المنتج المرسل
      return product;
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.sendTimeout) {
        throw NetworkException('Connection timeout');
      }
      if (e.response?.statusCode == 409) {
        throw ServerException('Product already exists in wishlist');
      }
      throw ServerException('Failed to add product: ${e.message}');
    } catch (e) {
      if (e is ServerException || e is NetworkException) {
        rethrow;
      }
      throw ServerException('Unexpected error: ${e.toString()}');
    }
  }

  @override
  Future<void> removeFromWishlist(String productId) async {
    try {
      final response = await client.delete<dynamic>(
        '$baseUrl/api/wishlist/$productId',
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );

      if (response.statusCode != 200 && response.statusCode != 204) {
        throw ServerException('Failed to remove product from wishlist');
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.sendTimeout) {
        throw NetworkException('Connection timeout');
      }
      if (e.response?.statusCode == 404) {
        // المنتج غير موجود، نعتبر العملية ناجحة
        return;
      }
      throw ServerException('Failed to remove product: ${e.message}');
    } catch (e) {
      if (e is ServerException || e is NetworkException) {
        rethrow;
      }
      throw ServerException('Unexpected error: ${e.toString()}');
    }
  }

  @override
  Future<WishlistProductModel> toggleFavorite(String productId) async {
    try {
      final response = await client.patch<dynamic>(
        '$baseUrl/api/wishlist/$productId/toggle',
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );

      if (response.statusCode != 200) {
        throw ServerException('Failed to toggle favorite status');
      }

      final map = _toMap(response.data);
      if (map == null) {
        throw ServerException('Invalid response format');
      }

      final productData = map['data'] ?? map['product'] ?? map;
      if (productData is Map) {
        return WishlistProductModel.fromJson(
          Map<String, dynamic>.from(productData),
        );
      }

      throw ServerException('Invalid response format');
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.sendTimeout) {
        throw NetworkException('Connection timeout');
      }
      if (e.response?.statusCode == 404) {
        throw ServerException('Product not found in wishlist');
      }
      throw ServerException('Failed to toggle favorite: ${e.message}');
    } catch (e) {
      if (e is ServerException || e is NetworkException) {
        rethrow;
      }
      throw ServerException('Unexpected error: ${e.toString()}');
    }
  }
}
