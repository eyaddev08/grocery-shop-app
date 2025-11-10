import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entiites/card_info.dart';
import '../repositories/payment_repository.dart';

class TokenizeAndPayUseCase {
  TokenizeAndPayUseCase(this.repo);
  final PaymentRepository repo;

  Future<Either<Failure, PaymentResult>> call(CardInfo card, double amount) => repo.tokenizeAndPay(card, amount);
}