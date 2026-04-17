import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:grocery_shop_app/core/constants/app_colors.dart';
import 'package:grocery_shop_app/core/widgets/custom_app_bar_widget.dart';
import 'package:grocery_shop_app/core/widgets/custom_button_widget.dart';
import 'package:grocery_shop_app/features/location/domain/entities/location_entity.dart';
import 'package:grocery_shop_app/features/location/presentation/manager/location_cubit.dart';
import 'package:grocery_shop_app/features/location/presentation/manager/location_state.dart';
import 'package:grocery_shop_app/features/location/presentation/widgets/recent_locations_list.dart';

import '../../../../core/widgets/custom_snackbar_widget.dart';
import '../widgets/address_preview.dart';
import '../widgets/map_search_bar_widget.dart';

class MapPickerScreen extends StatefulWidget {
  const MapPickerScreen({super.key});

  static Future<LocationEntity?> push(BuildContext context) async =>
      Navigator.of(context).push<LocationEntity>(
        MaterialPageRoute(
          builder: (_) => const MapPickerScreen(),
        ),
      );

  @override
  State<MapPickerScreen> createState() => _MapPickerScreenState();
}

class _MapPickerScreenState extends State<MapPickerScreen> {
  GoogleMapController? _mapController;
  bool _isMapInitialized = false;
  bool _isSearchVisible = false;

  @override
  void initState() {
    super.initState();
    // Initialize the location cubit when screen opens
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<LocationCubit>().init();
    });
  }

  @override
  void dispose() {
    _mapController?.dispose();
    super.dispose();
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
    _isMapInitialized = true;
  }

  Future<void> _updateCameraPosition(LatLng target, {double? zoom}) async {
    if (_mapController != null && _isMapInitialized) {
      await _mapController!.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: target,
            zoom: zoom ?? 16,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) =>
      BlocConsumer<LocationCubit, LocationState>(
        listener: (context, state) {
          if (state is LocationReverseLoaded) {
            Navigator.of(context).pop<LocationEntity>(state.location);
          } else if (state is LocationError) {
            showCustomSnackBarWidget(
                state.message, sanckBarType: SnackBarType.error, context);
          } else if (state is LocationMapReady) {
            _updateCameraPosition(
              state.selectedLatLng,
              zoom: state.cameraPosition.zoom,
            );
          }
        },
        builder: (context, state) {
          final cubit = context.read<LocationCubit>();
          final isLoading = state is LocationReverseLoading;

          CameraPosition initialCamera = const CameraPosition(
            target: LatLng(15.35724, 44.17961),
            zoom: 14,
          );
          LatLng markerPosition = const LatLng(15.35724, 44.17961);
          List<LocationEntity> recent = const [];

          if (state is LocationMapReady) {
            initialCamera = state.cameraPosition;
            markerPosition = state.selectedLatLng;
            recent = state.recentLocations;
          }

          return Scaffold(
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(50),
              child: CustomAppBarWidget(
                label: 'Pick location',
                isBackButtonExist: true,
                showCartIcon: false,
                centerTitle: true,
                onSearch: () {
                  setState(() {
                    _isSearchVisible = !_isSearchVisible;
                  });
                },
              ),
            ),
            body: Stack(
              children: [
                GoogleMap(
                  initialCameraPosition: initialCamera,
                  myLocationEnabled: true,
                  myLocationButtonEnabled: false,
                  zoomControlsEnabled: false,
                  mapType: MapType.normal,
                  onMapCreated: _onMapCreated,
                  markers: {
                    Marker(
                      markerId: const MarkerId('selected'),
                      position: markerPosition,
                      draggable: true,
                      onDragEnd: cubit.moveMarker,
                    ),
                  },
                  onTap: cubit.moveMarker,
                ),
                // Search bar
                if (_isSearchVisible)
                  Positioned(
                    top: 16,
                    left: 16,
                    right: 16,
                    child: MapSearchBarWidget(
                      onSubmitted: () {
                        setState(() {
                          _isSearchVisible = false;
                        });
                      },
                    ),
                  ),
                // Locate me button
                Positioned(
                  right: 16,
                  bottom: 140,
                  child: FloatingActionButton(
                    heroTag: 'locate_me',
                    backgroundColor: kAccentYellow,
                    onPressed: cubit.getCurrentLocation,
                    child: const Icon(Icons.my_location),
                  ),
                ),
                // Bottom sheet: address + confirm button + recent
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
                    decoration: BoxDecoration(
                      color: kSoftBg,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 8,
                          offset: const Offset(0, -2),
                        ),
                      ],
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(16),
                      ),
                    ),
                    child: SafeArea(
                      top: false,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          AddressPreview(state: state),
                          const SizedBox(height: 12),
                          CustomButton(
                            onPressed:
                                isLoading ? null : cubit.confirmSelection,
                            buttonText: 'Site confirmation',
                            buttonHeight: 50,
                            isLoading: isLoading,
                            isBorder: true,
                            radius: 12,
                            borderWidth: 0,
                          ),
                          const SizedBox(height: 12),
                          RecentLocationsList(
                            locations: recent,
                            onTapLocation: (loc) {
                              cubit.moveMarker(
                                LatLng(loc.latitude, loc.longitude),
                              );
                            },
                            onClear: () async {
                              // Clearing can be implemented by overwriting box,
                              // but for now just reload cached list.
                              await cubit.loadCachedLocations();
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      );
}
