
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/error/failure.dart';
import '../../domain/entities/address.dart';
import '../../domain/entities/label_entity.dart';
import '../../domain/usecases/add_address.dart';
import '../../domain/usecases/delete_address.dart';
import '../../domain/usecases/get_address_type.dart';
import '../../domain/usecases/get_addresses.dart';
import '../../domain/usecases/set_default_address.dart';
import '../../domain/usecases/update_address.dart';
import 'checkout_state.dart';

class CheckoutCubit extends Cubit<CheckoutState> {
  CheckoutCubit({
    required this.getAddresses,
    required this.getAddressType,
    required this.addAddress,
    required this.updateAddress,
    required this.setDefaultAddress,
    required this.deleteAddress,
  }) : super(const CheckoutInitial());

  final GetAddressesUseCase getAddresses;
  final GetAddressTypeUseCase getAddressType;
  final AddAddressUseCase addAddress; 
  final UpdateAddressUseCase updateAddress; 
  final SetDefaultAddressUseCase setDefaultAddress;
  final DeleteAddressUseCase deleteAddress; 

  List<LabelAsEntity> addressTypeList = [];

  int _selectAddressIndex = 0;
  int get selectAddressIndex => _selectAddressIndex;

  void _emitAddressTypesLoaded([int selectedIndex = 0]) {
    emit(CheckoutAddressTypesLoaded(addressTypeList, selectedIndex: selectedIndex));
  }

  Future<void> loadAddresses() async {
    emit(const CheckoutLoading());

    final Either<Failure, List<Address>> result = await getAddresses();
    result.fold(
      (failure) => emit(CheckoutError(failure.message)),
      (addresses) {
        if (addresses.isEmpty) {
          emit(const CheckoutEmpty());
        } else {
          String? selectedId;
          try {
            final defaultAddr = addresses.firstWhere((a) => a.isDefault,
                orElse: () => addresses.first);
            selectedId = defaultAddr.id;
          } catch (_) {
            selectedId = null;
          }
          emit(CheckoutLoaded(addresses, selectedAddressId: selectedId));
        }
      },
    );
  }

  Future<void> createAddress({
    required String label,
    required String addressType,
    required String details,
  }) async {
    emit(const CheckoutLoading());
    final id = const Uuid().v4();
    final a = Address(id: id, label: label, addressType: addressType, details: details);

    final Either<Failure, Unit> result = await addAddress(a);
    result.fold(
      (failure) => emit(CheckoutError(failure.message)),
      (_) async => await loadAddresses(),
    );
  }

  Future<void> editAddress({
    required String id,
    required String label,
    required String addressType,
    required String details,
  }) async {
    emit(const CheckoutLoading());
    final a = Address(id: id, label: label, addressType: addressType, details: details);

    final Either<Failure, Unit> result = await updateAddress(a);
    result.fold(
      (failure) => emit(CheckoutError(failure.message)),
      (_) async => await loadAddresses(),
    );
  }

  Future<void> chooseDefault(String id) async {
    emit(const CheckoutLoading());
    final Either<Failure, Unit> result = await setDefaultAddress(id);
    result.fold(
      (failure) => emit(CheckoutError(failure.message)),
      (_) async => await loadAddresses(),
    );
  }

  Future<void> removeAddress(String id) async {
    emit(const CheckoutLoading());
    final Either<Failure, Unit> result = await deleteAddress(id);
    result.fold(
      (failure) => emit(CheckoutError(failure.message)),
      (_) async => await loadAddresses(),
    );
  }

  Future<void> getAddressTypes() async {
    emit(const CheckoutAddressTypesLoading());

    final Either<Failure, List<LabelAsEntity>> result = await getAddressType();
    result.fold(
      (failure) => emit(CheckoutAddressTypesError(failure.message)),
      (types) {
        addressTypeList = types;
        if (_selectAddressIndex >= addressTypeList.length) {
          _selectAddressIndex = 0;
        }
        _emitAddressTypesLoaded(_selectAddressIndex);
      },
    );
  }

  void updateAddressIndex(int index, bool notify) {
    _selectAddressIndex = index;
    if (notify) {
      _emitAddressTypesLoaded(_selectAddressIndex);
    }
  }
}