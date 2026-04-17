import 'package:dio/dio.dart';

import '../../../../core/error/exception.dart';
import '../models/card_model.dart';
import '../models/payment_result_model.dart';
import 'payment_remote_data_source.dart';

/// A simple HTTP implementation of [PaymentRemoteDataSource].
///
/// In this demo project we don't have a real backend, so the class contains
/// the same validation logic that the old mock repository previously had.  In
/// a production app you would call the API and deserialize the response.
class PaymentRemoteDataSourceImpl implements PaymentRemoteDataSource {
  PaymentRemoteDataSourceImpl({required this.client, this.baseUrl = ''});

  final Dio client;
  final String baseUrl;

  @override
  Future<PaymentResultModel> tokenizeAndPay(
      CardModel card, double amount) async {
    // simulate network latency and basic server-side validation
    await Future<void>.delayed(const Duration(seconds: 1));

    final digits = card.number.replaceAll(' ', '');
    if (digits.length < 12) throw ServerException('Invalid card number');
    if (card.cvc.length < 3) throw ServerException('Invalid CVC');
    final parts = card.expiry.split('/');
    if (parts.length != 2) throw ServerException('Invalid expiry');

    // in real implementation you would do something like:
    // final response = await client.post(
    //   '$baseUrl/api/payment',
    //   data: {'card': card.toJson(), 'amount': amount},
    // );
    // if (response.statusCode != 200) throw ServerException('payment failed');
    // return PaymentResultModel.fromJson(response.data);

    await Future<void>.delayed(const Duration(seconds: 1));
    return PaymentResultModel(
        transactionId: 'tx_${DateTime.now().millisecondsSinceEpoch}',
        amount: amount);
  }
}
