import 'package:hive/hive.dart';
import '../../../../core/error/exception.dart';
import '../models/address_model.dart';

abstract class CheckoutLocalDataSource {
  Future<void> cacheAddresses(List<AddressModel> addresses);
  Future<List<AddressModel>> getAddresses();
  Future<void> addAddress(AddressModel address);
  Future<void> updateAddress(AddressModel address);
  Future<void> setDefaultAddress(String id);
  Future<void> deleteAddress(String id);
}

class CheckoutLocalDataSourceImpl implements CheckoutLocalDataSource {
  final Box<AddressModel> addressBox;

  CheckoutLocalDataSourceImpl({required this.addressBox});

  @override
  Future<void> cacheAddresses(List<AddressModel> addresses) async {
    try {
      await addressBox.clear();
      await addressBox.putAll(addresses.asMap());
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<List<AddressModel>> getAddresses() async {
    try {
      return addressBox.values.toList();
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<void> addAddress(AddressModel address) async {
    try {
      final isFirst = addressBox.isEmpty;
      final toSave = AddressModel.fromEntity(
        address.copyWith(isDefault: isFirst ? true : address.isDefault),
      );
      await addressBox.put(toSave.id, toSave);
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<void> updateAddress(AddressModel address) async {
    try {
      if (addressBox.containsKey(address.id)) {
        await addressBox.put(address.id, address);
      }
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<void> setDefaultAddress(String id) async {
    try {
      final addresses = addressBox.values.toList();
      for (var address in addresses) {
        if (address.id == id) {
          await addressBox.put(
            address.id,
            AddressModel.fromEntity(address.copyWith(isDefault: true)),
          );
        } else if (address.isDefault) {
          await addressBox.put(
            address.id,
            AddressModel.fromEntity(address.copyWith(isDefault: false)),
          );
        }
      }
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<void> deleteAddress(String id) async {
    try {
      await addressBox.delete(id);

      // If we deleted the default, set first available to default
      if (addressBox.isNotEmpty && !addressBox.values.any((a) => a.isDefault)) {
        final first = addressBox.values.first;
        await addressBox.put(
          first.id,
          AddressModel.fromEntity(first.copyWith(isDefault: true)),
        );
      }
    } catch (e) {
      throw CacheException();
    }
  }
}
