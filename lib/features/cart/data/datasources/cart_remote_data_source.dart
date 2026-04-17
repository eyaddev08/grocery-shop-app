import 'package:dio/dio.dart';
import '../../../../core/error/exception.dart';
import '../models/cart_item_model.dart';

abstract class CartRemoteDataSource {
  Future<List<CartItemModel>> getCartItems(String userToken);
  Future<void> addToCart(String userToken, CartItemModel item);
  Future<void> removeFromCart(String userToken, String productId);
  Future<void> updateQuantity(String userToken, String productId, int quantity);
  Future<void> clearCart(String userToken);
}

class CartRemoteDataSourceImpl implements CartRemoteDataSource {
  CartRemoteDataSourceImpl({required this.dio});
  final Dio dio;


    @override
    Future<List<CartItemModel>> getCartItems(String userToken) async {
      try {
        final response = await dio.get(
          '/api/cart',
          options: Options(headers: {'Authorization': 'Bearer $userToken'}),
        );
        final data = response.data['data'] as List;
        return data
            .map((item) => CartItemModel.fromJson(item as Map<String, dynamic>))
            .toList();
      } on DioException catch (e) {
        throw ServerException.fromDioError(e);
      } catch (e) {
        throw ServerException('Unexpected Error Occurred');
      }
    }

    @override
    Future<void> addToCart(String userToken, CartItemModel item) async {
      try {
        await dio.post(
          '/api/cart/add',
          data: item.toJson(),
          options: Options(headers: {'Authorization': 'Bearer $userToken'}),
        );
      } on DioException catch (e) {
        throw ServerException.fromDioError(e);
      } catch (e) {
        throw ServerException('Failed to add item');
      }
    }

    @override
    Future<void> removeFromCart(String userToken, String productId) async {
      try {
        await dio.delete(
          '/api/cart/remove/$productId',
          options: Options(headers: {'Authorization': 'Bearer $userToken'}),
        );
      } on DioException catch (e) {
        throw ServerException.fromDioError(e);
      } catch (e) {
        throw ServerException('Failed to remove item');
      }
    }

    @override
    Future<void> updateQuantity(
        String userToken, String productId, int quantity) async {
      try {
        await dio.put(
          '/api/cart/update/$productId',
          data: {'quantity': quantity},
          options: Options(headers: {'Authorization': 'Bearer $userToken'}),
        );
      } on DioException catch (e) {
        throw ServerException.fromDioError(e);
      } catch (e) {
        throw ServerException('Failed to update quantity');
      }
    }

    @override
    Future<void> clearCart(String userToken) async {
      try {
        await dio.delete(
          '/api/cart/clear',
          options: Options(headers: {'Authorization': 'Bearer $userToken'}),
        );
      } on DioException catch (e) {
        throw ServerException.fromDioError(e);
      } catch (e) {
        throw ServerException('Failed to clear cart');
      }
    }
  }