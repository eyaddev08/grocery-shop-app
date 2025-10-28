
import '../entities/address.dart';
import '../repositories/address_repository.dart';

class AddAddressUseCase {
  AddAddressUseCase(this.repo);
  final AddressRepository repo;
  Future<void> call(Address address) => repo.addAddress(address);
}