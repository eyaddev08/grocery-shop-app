import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/styles.dart';
import '../manager/location_state.dart';

class AddressPreview extends StatelessWidget {
  const AddressPreview({super.key, required this.state});

  final LocationState state;

  @override
  Widget build(BuildContext context) {
    String text = 'Move the marker to select location';

    if (state is LocationReverseLoaded) {
      final s = state as LocationReverseLoaded;
      if (s.isOffline ||
          s.location.getHumanReadableAddress == 'Unknown Location') {
        text = 'Offline — coordinates only';
      } else {
        text = s.location.getHumanReadableAddress;
      }
    } else if (state is LocationError) {
      text = (state as LocationError).message;
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(
          Icons.location_on_outlined,
          color: kMuted,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: textBold.copyWith(color: kMuted),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
