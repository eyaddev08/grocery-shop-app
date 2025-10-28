import '../repositories/address_repository.dart';

class DeleteAddressUseCase {
  DeleteAddressUseCase(this.repo);
  final AddressRepository repo;
  Future<void> call(String id) => repo.deleteAddress(id);
}
