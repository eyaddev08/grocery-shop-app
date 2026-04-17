import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/services/navigation_service.dart';
import '../../../../core/widgets/custom_app_bar_widget.dart';
import '../../../../core/widgets/custom_button_widget.dart';
import '../../../../core/widgets/custom_snackbar_widget.dart';
import '../../../../core/widgets/confirm_dialog_widget.dart';
import '../../../location/domain/entities/location_entity.dart';
import '../../../location/presentation/manager/location_cubit.dart';
import '../../../location/presentation/manager/location_state.dart';
import '../../../location/presentation/screens/map_picker_screen.dart';
import '../manager/checkout_cubit.dart';
import '../../domain/entities/address_entity.dart';
import '../widgets/address_details_input_field.dart';
import '../widgets/address_type_list_view_builder.dart';
import '../widgets/map_preview_widget.dart';

class AddressFormScreen extends StatefulWidget {
  const AddressFormScreen({
    super.key,
    this.address,
  });

  final AddressEntity? address;

  /// Check if in edit mode
  bool get isEditMode => address != null;

  @override
  State<AddressFormScreen> createState() => _AddressFormScreenState();
}

class _AddressFormScreenState extends State<AddressFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _detailsController;
  LocationEntity? _selectedLocation;
  late CheckoutCubit _checkoutCubit;

  @override
  void initState() {
    super.initState();
    _checkoutCubit = context.read<CheckoutCubit>();
    _detailsController = TextEditingController(
      text: widget.address?.details ?? '',
    );

    if (widget.isEditMode &&
        widget.address?.latitude != null &&
        widget.address?.longitude != null) {
      try {
        _selectedLocation = LocationEntity(
          latitude: double.parse(widget.address!.latitude!),
          longitude: double.parse(widget.address!.longitude!),
          pickedAt: DateTime.now(),
          formattedAddress: widget.address?.address,
          street: widget.address?.address,
          city: widget.address?.city,
          country: widget.address?.country,
        );
      } catch (_) {}
    }

    context.read<CheckoutCubit>().getAddressTypes();

    if (widget.isEditMode) {
      final cubit = context.read<CheckoutCubit>();
      final at = widget.address!.addressType;
      if (at == 'Home') {
        cubit.updateAddressIndex(0, false);
      } else if (at == 'Workplace' || at == 'Office') {
        cubit.updateAddressIndex(1, false);
      } else {
        cubit.updateAddressIndex(2, false);
      }
    }
  }

  @override
  void dispose() {
    _detailsController.dispose();
    _checkoutCubit.loadAddresses();
    super.dispose();
  }

  Future<void> _openMapPicker() async {
    final locationCubit = context.read<LocationCubit>();

    if (locationCubit.state is LocationInitial) {
      await locationCubit.init();
    }

    final result = await Navigator.of(context).push<LocationEntity>(
      MaterialPageRoute(
        builder: (_) => BlocProvider.value(
          value: locationCubit,
          child: const MapPickerScreen(),
        ),
      ),
    );

    if (result != null && mounted) {
      setState(() {
        _selectedLocation = result;
        _detailsController.text = result.getHumanReadableAddress;
      });

      showCustomSnackBarWidget(
        widget.isEditMode
            ? 'Address details updated successfully'
            : 'Address details added successfully',
        context,
      );
    }
  }

  Future<void> _saveAddress() async {
    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }
    final bool confirm = await showDialog<bool>(
          context: context,
          builder: (context) => ConfirmDialogWidget(
              title: 'Confirmation',
              description: widget.isEditMode
                  ? 'Are you sure you want to save changes to this address?'
                  : 'Are you sure you want to save this new address?',
              onCancle: () => Navigator.of(context).pop(false),
              titleButton: 'Save',
              icon: Icons.location_on,
              onPressed: () => Navigator.of(context).pop(true)),
        ) ??
        false;

    if (!confirm) return;

    final cubit = _checkoutCubit;

    if (widget.isEditMode) {
      final type = (cubit.addressTypeList.isNotEmpty &&
              cubit.selectAddressIndex < cubit.addressTypeList.length)
          ? cubit.addressTypeList[cubit.selectAddressIndex].title
          : widget.address!.addressType;

      await cubit.editAddress(
        id: widget.address!.id,
        label: widget.address!.label,
        addressType: type,
        details: _detailsController.text.trim(),
        address: _selectedLocation?.formattedAddress,
        city: _selectedLocation?.city,
        country: _selectedLocation?.country,
        latitude: _selectedLocation?.latitude.toString(),
        longitude: _selectedLocation?.longitude.toString(),
      );
    } else {
      final type = cubit.addressTypeList.isNotEmpty &&
              cubit.selectAddressIndex < cubit.addressTypeList.length
          ? cubit.addressTypeList[cubit.selectAddressIndex].title
          : 'Home';

      await cubit.createAddress(
        label: type,
        addressType: type,
        details: _detailsController.text.trim(),
        address: _selectedLocation?.formattedAddress,
        city: _selectedLocation?.city,
        country: _selectedLocation?.country,
        latitude: _selectedLocation?.latitude.toString(),
        longitude: _selectedLocation?.longitude.toString(),
      );
    }

    if (mounted) {
      showCustomSnackBarWidget(
        widget.isEditMode
            ? 'Address updated successfully'
            : 'Address added successfully',
        context,
      );
      NavigationService.goBack();
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: CustomAppBarWidget(
            label: widget.isEditMode ? 'Edit Address' : 'Add New Address',
            labelSize: 19,
            labelColor: const Color(0xFF1E222B),
            backgroundColor: Colors.white,
            isBackButtonExist: true,
            showCartIcon: false,
            showSearchIcon: false,
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 12),
                AddressDetailsInputField(controller: _detailsController),
                const SizedBox(height: 20),
                const AddressTypeListViewBuilder(),
                const SizedBox(height: 20),
                MapPreviewWidget(
                  location: _selectedLocation,
                  onTap: _openMapPicker,
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.1),
              ],
            ),
          ),
        ),
        bottomNavigationBar: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: CustomButton(
              onPressed: _saveAddress,
              buttonText: widget.isEditMode ? 'Save Changes' : 'Save Address',
            ),
          ),
        ),
      );
}
