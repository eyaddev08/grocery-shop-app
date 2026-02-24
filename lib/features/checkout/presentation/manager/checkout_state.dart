// import 'package:equatable/equatable.dart';
// import '../../domain/entities/address.dart';
// import '../../domain/entities/label_entity.dart';

// abstract class CheckoutState extends Equatable {
//   const CheckoutState();

//   @override
//   List<Object?> get props => [];
// }

// class CheckoutInitial extends CheckoutState {
//   const CheckoutInitial();
// }

// class CheckoutLoading extends CheckoutState {
//   const CheckoutLoading();
// }

// class CheckoutEmpty extends CheckoutState {
//   const CheckoutEmpty();
// }

// class CheckoutLoaded extends CheckoutState {

//   const CheckoutLoaded(this.addresses, {this.selectedAddressId});
//   final List<Address> addresses;
//   /// id of the selected/default address (nullable)
//   final String? selectedAddressId;

//   @override
//   List<Object?> get props => [addresses, selectedAddressId];
// }
// class CheckoutAddressTypeLoaded extends CheckoutState {

//   const CheckoutAddressTypeLoaded( this.addressType);
//   final List<LabelAsEntity> addressType;


//   @override
//   List<Object?> get props => [addressType];
// }
// class CheckoutUpdateAddressIndex extends CheckoutState {}




// class CheckoutError extends CheckoutState {
//   const CheckoutError(this.message);
//   final String message;

//   @override
//   List<Object?> get props => [message];
// }

// lib/features/checkout/manager/checkout_state.dart

import 'package:equatable/equatable.dart';
import '../../domain/entities/address.dart';
import '../../domain/entities/label_entity.dart';

abstract class CheckoutState extends Equatable {
  const CheckoutState();

  @override
  List<Object?> get props => [];
}

class CheckoutInitial extends CheckoutState {
  const CheckoutInitial();
}

class CheckoutLoading extends CheckoutState {
  const CheckoutLoading();
}

class CheckoutEmpty extends CheckoutState {
  const CheckoutEmpty();
}

class CheckoutLoaded extends CheckoutState {
  final List<Address> addresses;
  final String? selectedAddressId;

  const CheckoutLoaded(this.addresses, {this.selectedAddressId});

  @override
  List<Object?> get props => [addresses, selectedAddressId];
}

class CheckoutAddressTypesLoading extends CheckoutState {
  const CheckoutAddressTypesLoading();
}

class CheckoutAddressTypesLoaded extends CheckoutState {
  final List<LabelAsEntity> types;
  final int selectedIndex;

  const CheckoutAddressTypesLoaded(this.types, {this.selectedIndex = 0});

  @override
  List<Object?> get props => [types, selectedIndex];
}

class CheckoutUpdateAddressIndex extends CheckoutState {
  const CheckoutUpdateAddressIndex();
}

class CheckoutError extends CheckoutState {
  final String message;
  const CheckoutError(this.message);

  @override
  List<Object?> get props => [message];
}

class CheckoutAddressTypesError extends CheckoutState {
  final String message;
  const CheckoutAddressTypesError(this.message);

  @override
  List<Object?> get props => [message];
}