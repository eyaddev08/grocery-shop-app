import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

import '../../domain/entities/address.dart';
import '../../domain/usecases/add_address.dart';
import '../../domain/usecases/delete_address.dart';
import '../../domain/usecases/get_addresses.dart';
import '../../domain/usecases/set_default_address.dart';
import '../../domain/usecases/update_address.dart';
import 'address_state.dart';

class AddressCubit extends Cubit<AddressState> {
  AddressCubit({
    required this.getAddresses,
    required this.addAddress,
    required this.updateAddress,
    required this.setDefaultAddress,
    required this.deleteAddress,
  }) : super(AddressInitial());
  final GetAddressesUseCase getAddresses;
  final AddAddressUseCase addAddress;
  final UpdateAddressUseCase updateAddress;
  final SetDefaultAddressUseCase setDefaultAddress;
  final DeleteAddressUseCase deleteAddress;

  Future<void> loadAddresses() async {
    emit(AddressLoading());
    try {
      final list = await getAddresses();
      if (list.isEmpty) {
        emit(AddressEmpty());
      } else {
        emit(AddressLoaded(list));
      }
    } catch (e) {
      emit(AddressError(e.toString()));
    }
  }

  Future<void> createAddress(
      {required String label, required String details}) async {
    final id = const Uuid().v4();
    final a = Address(id: id, label: label, details: details);
    await addAddress(a);
    await loadAddresses();
  }

  Future<void> editAddress(
      {required String id,
      required String label,
      required String details}) async {
    final a = Address(id: id, label: label, details: details);
    await updateAddress(a);
    await loadAddresses();
  }

  Future<void> chooseDefault(String id) async {
    await setDefaultAddress(id);
    await loadAddresses();
  }

  Future<void> removeAddress(String id) async {
    await deleteAddress(id);
    await loadAddresses();
  }
}
