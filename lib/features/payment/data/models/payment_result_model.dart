import '../../domain/entiites/card_info.dart';

/// Model used by the data layer to represent the result returned by the
/// payment gateway.
class PaymentResultModel extends PaymentResult {
  PaymentResultModel({
    required super.transactionId,
    required super.amount,
  });

  factory PaymentResultModel.fromJson(Map<String, dynamic> json) => PaymentResultModel(
      transactionId: json['transactionId'] as String,
      amount: (json['amount'] as num).toDouble(),
    );

  Map<String, dynamic> toJson() => {
        'transactionId': transactionId,
        'amount': amount,
      };
}
