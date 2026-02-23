import '../../../../core/error/failure.dart';
import 'package:dartz/dartz.dart';
import '../repositories/address_repository.dart';

class SetDefaultAddressUseCase {
  SetDefaultAddressUseCase(this.repo);
  final AddressRepository repo;
  Future<Either<Failure, Unit>> call(String id) => repo.setDefaultAddress(id);
}