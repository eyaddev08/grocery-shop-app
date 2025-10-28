import '../repositories/address_repository.dart';

class SetDefaultAddressUseCase {
  SetDefaultAddressUseCase(this.repo);
  final AddressRepository repo;
  Future<void> call(String id) => repo.setDefaultAddress(id);
}