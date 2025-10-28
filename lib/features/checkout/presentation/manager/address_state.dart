
import '../../domain/entities/address.dart';

abstract class AddressState {}

class AddressInitial extends AddressState {}

class AddressLoading extends AddressState {}

class AddressLoaded extends AddressState {
  AddressLoaded(this.addresses);
  final List<Address> addresses;
}

class AddressEmpty extends AddressState {}

class AddressError extends AddressState {
  AddressError(this.message);
  final String message;
}
