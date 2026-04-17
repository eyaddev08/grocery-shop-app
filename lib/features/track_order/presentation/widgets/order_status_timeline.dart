import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/styles.dart';

class OrderStatusTimeline extends StatelessWidget {

  const OrderStatusTimeline({
    super.key,
    required this.currentStatus,
  });
  final String currentStatus;

  @override
  Widget build(BuildContext context) {
    final steps = [
      'Order Placed',
      'Processing',
      'On the Way',
      'Delivered',
    ];

    int currentIndex = _getStatusIndex(currentStatus);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        children: List.generate(steps.length, (index) {
          final isCompleted = index <= currentIndex;
          final isLast = index == steps.length - 1;

          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isCompleted
                          ? kPrimaryBlue
                          : kAccentYellow.withOpacity(0.3),
                      border: Border.all(
                        color: isCompleted ? kPrimaryBlue : kAccentYellow,
                        width: 2,
                      ),
                    ),
                    child: isCompleted
                        ? const Icon(Icons.check, size: 14, color: Colors.white)
                        : null,
                  ),
                  if (!isLast)
                    Container(
                      width: 2,
                      height: 40,
                      color: isCompleted
                          ? kPrimaryBlue
                          : kAccentYellow.withOpacity(0.3),
                    ),
                ],
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 2),
                  child: Text(
                    steps[index],
                    style: textBold.copyWith(
                      color: isCompleted ? kTextDark : Colors.grey.shade500,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }

  int _getStatusIndex(String status) {
    // Map existing OrderStatus names to index
    switch (status.toLowerCase()) {
      case 'active':
      case 'processing':
        return 1;
      case 'ontheway':
      case 'on_the_way':
        return 2;
      case 'success':
      case 'delivered':
        return 3;
      case 'placed':
      default:
        return 0;
    }
  }
}
