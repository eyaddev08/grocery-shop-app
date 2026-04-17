import '../models/card_model.dart';
import '../models/payment_result_model.dart';


abstract class PaymentRemoteDataSource {

  Future<PaymentResultModel> tokenizeAndPay(CardModel card, double amount);
}
