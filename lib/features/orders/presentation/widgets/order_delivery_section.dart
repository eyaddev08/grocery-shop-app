import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/styles.dart';
import '../../../../core/utils/images.dart';
import '../../../../core/widgets/custom_button_widget.dart';
import '../../../../core/widgets/order_rider_avatar_widget.dart';

class OrderDeliverySection extends StatelessWidget {
  const OrderDeliverySection({
    super.key,
    required this.deliveryMessage,
    this.riderName,
    this.onTrackOrder,
  });

  final String? deliveryMessage;
  final String? riderName;
  final VoidCallback? onTrackOrder;

  @override
  Widget build(BuildContext context) {
    final messageParts = _parseDeliveryMessage(deliveryMessage);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildDeliveryIllustration(),
        const SizedBox(width: 8),
        Expanded(
          child: _buildMessageAndButton(messageParts),
        ),
      ],
    );
  }

  Widget _buildDeliveryIllustration() => Column(
      children: [
        Stack(
          children: [
            Image.asset(
              Images.deliveryImage,
              width: 175,
              fit: BoxFit.fill,
            ),
            if (riderName != null)
              const Positioned(
                left: 62,
                top: 86,
                child: OrderRiderAvatar(),
              ),
          ],
        ),
        if (riderName != null) ...[
          const SizedBox(height: 10),
          _buildRiderName(),
        ],
      ],
    );

  Widget _buildRiderName() => Row(
      children: [
        Text(
          'Meet our rider, ',
          style: titilliumRegular.copyWith(
            color: kTextGray,
            fontWeight: FontWeight.w400,
          ),
        ),
        Text(
          riderName!,
          style: titilliumRegular.copyWith(
            color: kMuted,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );

  Widget _buildMessageAndButton(Map<String, String> messageParts) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              messageParts['first'] ?? 'Your',
              style: titleHeader.copyWith(
                color: kTextDark,
                fontSize: 20,
                fontWeight: FontWeight.w400,
              ),
            ),
            Text(
              messageParts['second'] ?? 'order is on the way',
              maxLines: 1,
              style: titleHeader.copyWith(
                color: kTextDark,
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        const SizedBox(height: 15),
        CustomButton(
          buttonText: 'Track Order',
          radius: 20,
          buttonWidth: 115,
          onTap: onTrackOrder ?? () {},
        ),
      ],
    );

  Map<String, String> _parseDeliveryMessage(String? message) {
    if (message == null || message.isEmpty) {
      return {
        'first': 'Your',
        'second': 'order is on the way',
      };
    }

    final words = message.split(' ');
    if (words.length < 2) {
      return {
        'first': message,
        'second': '',
      };
    }

    final firstPart = words.getRange(0, 2).join(' ');
    final secondPart = words.length > 2
        ? words.getRange(2, words.length > 6 ? 6 : words.length).join(' ')
        : '';

    return {
      'first': firstPart,
      'second': secondPart.isEmpty ? 'order is on the way' : secondPart,
    };
  }
}
