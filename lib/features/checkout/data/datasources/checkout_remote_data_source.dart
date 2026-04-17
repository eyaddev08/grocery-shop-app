import 'package:dio/dio.dart';
import '../../../../core/error/exception.dart';
import '../models/address_model.dart';


abstract class CheckoutRemoteDataSource {
  Future<List<AddressModel>> getAddresses();
  Future<void> addAddress(AddressModel address);
  Future<void> updateAddress(AddressModel address);
  Future<void> setDefaultAddress(String id);
  Future<void> deleteAddress(String id);
}

class CheckoutRemoteDataSourceImpl implements CheckoutRemoteDataSource {
  final Dio client;

  CheckoutRemoteDataSourceImpl({required this.client});

  @override
  Future<List<AddressModel>> getAddresses() async {
    try {
      final response = await client.get('/addresses');
      return (response.data['data'] as List).map((e) => AddressModel.fromJson(e as Map<String, dynamic>)).toList();
    } on DioException catch (e) {
      throw ServerException.fromDioError(e);
    } catch (e) {
      throw ServerException('Failed to get addresses');
    }
  }

  @override
  Future<void> addAddress(AddressModel address) async {
    try {
      await client.post('/addresses', data: address.toJson());
   } on DioException catch (e) {
        throw ServerException.fromDioError(e);
      } catch (e) {
        throw ServerException('Failed to add address');
      }
  }

  @override
  Future<void> updateAddress(AddressModel address) async {
    try {
      await client.put('/addresses/${address.id}', data: address.toJson());
   } on DioException catch (e) {
        throw ServerException.fromDioError(e);
      } catch (e) {
        throw ServerException('Failed to update address');
      }
  }

  @override
  Future<void> setDefaultAddress(String id) async {
   try {
      await client.post('/addresses/$id/default');
   } on DioException catch (e) {
        throw ServerException.fromDioError(e);
      } catch (e) {
        throw ServerException('Failed to set default address');
      }
  }

  @override
  Future<void> deleteAddress(String id) async {
    try {
      await client.delete('/addresses/$id');
   } on DioException catch (e) {
        throw ServerException.fromDioError(e);
      } catch (e) {
        throw ServerException('Failed to delete address');
      }
  }
}
