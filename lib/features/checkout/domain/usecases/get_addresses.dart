import '../entities/address.dart';
import '../repositories/address_repository.dart';

class GetAddressesUseCase {
  GetAddressesUseCase(this.repo);
  final AddressRepository repo;
  Future<List<Address>> call() => repo.getAddresses();
}
