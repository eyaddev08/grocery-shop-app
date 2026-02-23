import '../../../../core/error/failure.dart';
import 'package:dartz/dartz.dart';
import '../entities/label_entity.dart';
import '../repositories/address_repository.dart';

class GetAddressTypeUseCase {
  GetAddressTypeUseCase(this.repo);
  final AddressRepository repo;
  Future< Either<Failure, List<LabelAsEntity>>> call() => repo.getAddressType();
}
