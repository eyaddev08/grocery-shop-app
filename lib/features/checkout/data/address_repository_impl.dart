import '../domain/entities/address.dart';
import '../domain/repositories/address_repository.dart';

class InMemoryAddressRepository implements AddressRepository {
  final List<Address> _storage = [];

  @override
  Future<List<Address>> getAddresses() async {
    await Future.delayed(const Duration(milliseconds: 250));
    return List<Address>.from(_storage);
  }

  @override
  Future<void> addAddress(Address address) async {
    await Future.delayed(const Duration(milliseconds: 150));
    final isFirst = _storage.isEmpty;
    final toSave =
        address.copyWith(isDefault: isFirst ? true : address.isDefault);
    _storage.add(toSave);
  }

  @override
  Future<void> updateAddress(Address address) async {
    final idx = _storage.indexWhere((a) => a.id == address.id);
    if (idx >= 0) {
      _storage[idx] = address;
    }
    await Future.delayed(const Duration(milliseconds: 120));
  }

  @override
  Future<void> setDefaultAddress(String id) async {
    for (var i = 0; i < _storage.length; i++) {
      if (_storage[i].id == id) {
        _storage[i] = _storage[i].copyWith(isDefault: true);
      } else {
        _storage[i] = _storage[i].copyWith(isDefault: false);
      }
    }
    await Future.delayed(const Duration(milliseconds: 120));
  }

  @override
  Future<void> deleteAddress(String id) async {
    _storage.removeWhere((a) => a.id == id);
    // بعد الحذف: إذا لم يعد هناك default، عيّن الأول إن وجد
    if (_storage.isNotEmpty && !_storage.any((a) => a.isDefault)) {
      _storage[0] = _storage[0].copyWith(isDefault: true);
    }
    await Future.delayed(const Duration(milliseconds: 120));
  }
}

