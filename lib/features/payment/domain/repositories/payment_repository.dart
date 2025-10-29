import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entiites/card_info.dart';

abstract class PaymentRepository {
  /// Tokenize card & make payment, returns Either<Failure, PaymentResult>
  Future<Either<Failure, PaymentResult>> tokenizeAndPay(CardInfo card, double amount);
}