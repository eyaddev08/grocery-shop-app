import 'package:flutter/foundation.dart';
import 'package:grocery_shop_app/features/checkout/domain/entities/label_entity.dart';

import '../../../core/error/failure.dart';
import 'package:dartz/dartz.dart';
import '../../../core/utils/images.dart';
import '../domain/entities/address.dart';
import '../domain/repositories/address_repository.dart';

class InMemoryAddressRepository implements AddressRepository {
  final List<Address> _storage = [];

  @override
  Future<Either<Failure, List<Address>>> getAddresses() async {
    await Future<void>.delayed(const Duration(milliseconds: 250));
    return Right(List<Address>.from(_storage));
  }

  @override
  Future<Either<Failure, Unit>> addAddress(Address address) async {
    await Future<void>.delayed(const Duration(milliseconds: 150));
    final isFirst = _storage.isEmpty;
    final toSave =
        address.copyWith(isDefault: isFirst ? true : address.isDefault);
    _storage.add(toSave);
    return Right(unit);
  }

  @override
  Future<Either<Failure, Unit>> updateAddress(Address address) async {
    final idx = _storage.indexWhere((a) => a.id == address.id);
    if (idx >= 0) {
      _storage[idx] = address;
    }
    await Future<void>.delayed(const Duration(milliseconds: 120));
    return Right(unit);
  }

  @override
  Future<Either<Failure, Unit>> setDefaultAddress(String id) async {
    for (var i = 0; i < _storage.length; i++) {
      if (_storage[i].id == id) {
        _storage[i] = _storage[i].copyWith(isDefault: true);
      } else {
        _storage[i] = _storage[i].copyWith(isDefault: false);
      }
    }
    await Future<void>.delayed(const Duration(milliseconds: 120));
    return Right(unit);
  }

  @override
  Future<Either<Failure, Unit>> deleteAddress(String id) async {
    _storage.removeWhere((a) => a.id == id);
    // بعد الحذف: إذا لم يعد هناك default، عيّن الأول إن وجد
    if (_storage.isNotEmpty && !_storage.any((a) => a.isDefault)) {
      _storage[0] = _storage[0].copyWith(isDefault: true);
    }
    await Future<void>.delayed(const Duration(milliseconds: 120));
    return const Right(unit);
  }

  @override
  Future<Either<Failure, List<LabelAsEntity>>> getAddressType() async {
    await Future<void>.delayed(const Duration(milliseconds: 250));

    final List<LabelAsEntity> labelAsList = [
      LabelAsEntity('Home', Images.homeImage),
      LabelAsEntity('Office', Images.officeIcon),
      LabelAsEntity('Others', Images.address),
    ];
    return Right(labelAsList);
  }
}
