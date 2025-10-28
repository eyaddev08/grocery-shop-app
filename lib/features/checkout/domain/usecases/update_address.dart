import '../entities/address.dart';
import '../repositories/address_repository.dart';

class UpdateAddressUseCase {
  UpdateAddressUseCase(this.repo);
  final AddressRepository repo;
  Future<void> call(Address address) => repo.updateAddress(address);
}

