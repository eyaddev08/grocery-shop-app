import 'package:dio/dio.dart';
import '../../../../core/error/exception.dart';
import '../models/wishlist_product_model.dart';

abstract class WishlistRemoteDataSource {
  Future<List<WishlistProductModel>> getWishlist();

  Future<WishlistProductModel> addToWishlist(WishlistProductModel product);

  Future<void> removeFromWishlist(String productId);

  Future<WishlistProductModel> toggleFavorite(String productId);
}



class WishlistRemoteDataSourceImpl implements WishlistRemoteDataSource {

  WishlistRemoteDataSourceImpl({required this.client, this.baseUrl = ''});
  final Dio client;
  final String baseUrl;


  @override
  Future<List<WishlistProductModel>> getWishlist() async =>
      _processRequest<List<WishlistProductModel>>(
        request: () => client.get('$baseUrl/api/wishlist'),
        onSuccess: (data) {
          final List<dynamic> rawList =
              (data['data'] ?? data['products'] ?? data['wishlist'] ?? <List<dynamic>>[])  as List<dynamic>;
          return rawList
              .map((e) =>
                  WishlistProductModel.fromJson(Map<String, dynamic>.from(e as Map<String, dynamic>)))
              .toList();
        },
      );

  @override
  Future<WishlistProductModel> addToWishlist(
          WishlistProductModel product) async =>
      _processRequest<WishlistProductModel>(
        request: () => client.post('$baseUrl/api/wishlist', data: product.toJson()),
        onSuccess: (data) {
          final productData = data['data'] ?? data['product'] ?? data;
          return WishlistProductModel.fromJson(
              Map<String, dynamic>.from(productData as Map<String, dynamic>));
        },
      );

  @override
  Future<void> removeFromWishlist(String productId) async {
    await _processRequest<void>(
      request: () => client.delete('$baseUrl/api/wishlist/$productId'),
      onSuccess: (_) {},
    );
  }

  @override
  Future<WishlistProductModel> toggleFavorite(String productId) async =>
      _processRequest<WishlistProductModel>(
        request: () => client.patch('$baseUrl/api/wishlist/$productId/toggle'),
        onSuccess: (data) {
          final productData = data['data'] ?? data['product'] ?? data;
          return WishlistProductModel.fromJson(
              Map<String, dynamic>.from(productData as Map<String, dynamic>));
        },
      );

  Future<T> _processRequest<T>({
    required Future<Response<dynamic>> Function() request,
    required T Function(dynamic data) onSuccess,
  }) async {
    try {
      final response = await request();

      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        return onSuccess(response.data);
      } else {
        throw ServerException(
            'Server error with status: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  Exception _handleDioError(DioException e) {
    if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.receiveTimeout) {
      return NetworkException('Connection timeout');
    }

    // معالجة الأخطاء بناءً على الـ status code القادم من السيرفر
    final statusCode = e.response?.statusCode;
    if (statusCode == 404) return ServerException('Resource not found');
    if (statusCode == 409)
      return ServerException('Conflict: Item already exists');
    if (statusCode == 401) return ServerException('Unauthorized access');

    return ServerException(e.message ?? 'Unknown server error');
  }
}
