import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/styles.dart';
import '../../../location/domain/entities/location_entity.dart';

/// Widget that displays a preview of the map and allows opening the full map picker
class MapPreviewWidget extends StatelessWidget {
  const MapPreviewWidget({
    super.key,
    this.location,
    required this.onTap,
  });

  final LocationEntity? location;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: onTap,
        child: Container(
          height: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: location != null
                  ? kAccentYellow
                  : kAccentYellow.withOpacity(0.65),
              width: 2,
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Stack(
              children: [
                // Google Map preview
                if (location != null)
                  GoogleMap(
                    key: ValueKey(
                        '${location!.latitude}_${location!.longitude}'),
                    initialCameraPosition: CameraPosition(
                      target: LatLng(location!.latitude, location!.longitude),
                      zoom: 15,
                    ),
                    myLocationEnabled: false,
                    myLocationButtonEnabled: false,
                    zoomControlsEnabled: false,
                    mapToolbarEnabled: false,
                    markers: {
                      Marker(
                        markerId: const MarkerId('preview'),
                        position: LatLng(
                          location!.latitude,
                          location!.longitude,
                        ),
                      ),
                    },
                  )
                else
                  Container(
                    color: kSoftBg,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.map_outlined,
                            size: 48,
                            color: kMutedGray,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Tap to select location on map',
                            style: textMedium.copyWith(color: kMutedGray),
                          ),
                        ],
                      ),
                    ),
                  ),
                // Overlay with tap indicator
                Positioned.fill(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: kAccentYellow.withOpacity(0.9),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.location_on,
                              color: Colors.white,
                              size: 20,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              location != null
                                  ? 'Change location'
                                  : 'Select location',
                              style: textBold.copyWith(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
