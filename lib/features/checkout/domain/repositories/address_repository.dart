import '../entities/address.dart';

abstract class AddressRepository {
  Future<List<Address>> getAddresses();
  Future<void> addAddress(Address address);
  Future<void> updateAddress(Address address);
  Future<void> setDefaultAddress(String id);
  Future<void> deleteAddress(String id);
}
