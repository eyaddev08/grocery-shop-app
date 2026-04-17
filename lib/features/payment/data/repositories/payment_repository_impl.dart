import 'package:dartz/dartz.dart';

import '../../../../core/error/exception.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entiites/card_info.dart';
import '../../domain/repositories/payment_repository.dart';
import '../datasources/payment_remote_data_source.dart';
import '../models/card_model.dart';

/// Concrete implementation of [PaymentRepository] that speaks to a remote
/// datasource.  Network connectivity is checked before attempting the call.
class PaymentRepositoryImpl implements PaymentRepository {
  PaymentRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  final PaymentRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  @override
  Future<Either<Failure, PaymentResult>> tokenizeAndPay(
      CardInfo card, double amount) async {
    if (!await networkInfo.isConnected) {
      return Left(NetworkFailure( 'No internet connection'));
    }

    try {
      final model = await remoteDataSource.tokenizeAndPay(
          CardModel.fromEntity(card), amount);
      // PaymentResultModel extends PaymentResult so we can return it directly
      return Right(model);
    }  on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      }
  }
}
