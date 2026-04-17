import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/address_entity.dart';
import '../repositories/address_repository.dart';

class UpdateAddressUseCase {
  UpdateAddressUseCase(this.repo);
  final AddressRepository repo;
  Future<Either<Failure, Unit>> call(AddressEntity address) =>
      repo.updateAddress(address);
}
