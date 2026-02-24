import '../../../../core/error/failure.dart';
import 'package:dartz/dartz.dart';
import '../entities/address.dart';
import '../repositories/address_repository.dart';

class GetAddressesUseCase {
  GetAddressesUseCase(this.repo);
  final AddressRepository repo;
  Future<Either<Failure, List<Address>>> call() => repo.getAddresses();
}
