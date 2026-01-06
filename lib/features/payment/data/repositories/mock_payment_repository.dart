import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../domain/entiites/card_info.dart';
import '../../domain/repositories/payment_repository.dart';

class MockPaymentRepository implements PaymentRepository {
  @override
  Future<Either<Failure, PaymentResult>> tokenizeAndPay(CardInfo card, double amount) async {
    // emulate network latency
    await Future<void>.delayed(const Duration(seconds: 1));

    // simple validation logic (server-side should validate in real world)
    final digits = card.number.replaceAll(' ', '');
    if (digits.length < 12) return left(Failure('Invalid card number'));
    if (card.cvc.length < 3) return left(Failure('Invalid CVC'));
    final parts = card.expiry.split('/');
    if (parts.length != 2) return left(Failure('Invalid expiry'));

    // emulate tokenization & payment processing
  await Future<void>.delayed(const Duration(seconds: 1));
    // success
    final result = PaymentResult(transactionId: 'tx_${DateTime.now().millisecondsSinceEpoch}', amount: amount);
    return right(result);
  }
}