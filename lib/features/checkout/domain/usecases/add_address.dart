import '../../../../core/error/failure.dart';
import 'package:dartz/dartz.dart';
import '../entities/address_entity.dart';
import '../repositories/address_repository.dart';

class AddAddressUseCase {
  AddAddressUseCase(this.repo);
  final AddressRepository repo;
  Future<Either<Failure, Unit>> call(AddressEntity address) =>
      repo.addAddress(address);
}
