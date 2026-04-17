import '../../../../core/error/failure.dart';
import 'package:dartz/dartz.dart';
import '../entities/address_entity.dart';
import '../entities/label_entity.dart';

abstract class AddressRepository {
  Future<Either<Failure, List<AddressEntity>>> getAddresses();
  Future<Either<Failure, List<LabelAsEntity>>> getAddressType();

  Future<Either<Failure, Unit>> addAddress(AddressEntity address);

  Future<Either<Failure, Unit>> updateAddress(AddressEntity address);
  Future<Either<Failure, Unit>> setDefaultAddress(String id);
  Future<Either<Failure, Unit>> deleteAddress(String id);
}
