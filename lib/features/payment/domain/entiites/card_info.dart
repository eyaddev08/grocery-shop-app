class PaymentResult {
  PaymentResult({required this.transactionId, required this.amount});
  final String transactionId;
  final double amount;
}

class CardInfo {
  CardInfo({
    required this.holderName,
    required this.number,
    required this.expiry,
    required this.cvc,
    required this.brand,
  });
  final String holderName;
  final String number;
  final String expiry; // MM/YY
  final String cvc;
  final String brand;
}