import 'package:grocery_shop_app/features/checkout/domain/entities/label_entity.dart';

import '../../../../core/error/failure.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/utils/images.dart';
import '../../domain/entities/address_entity.dart';
import '../models/address_model.dart';

import '../../domain/repositories/address_repository.dart';

import 'package:grocery_shop_app/features/checkout/data/datasources/checkout_local_data_source.dart';
import 'package:grocery_shop_app/features/checkout/data/datasources/checkout_remote_data_source.dart';
import '../../../../../core/network/network_info.dart';

class AddressRepositoryImpl implements AddressRepository {

  AddressRepositoryImpl({
    required this.localDataSource,
    required this.remoteDataSource,
    required this.networkInfo,
  });
  final CheckoutLocalDataSource localDataSource;
  final CheckoutRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  @override
  Future<Either<Failure, List<AddressEntity>>> getAddresses() async {
    try {
      if (await networkInfo.isConnected) {
        // final remoteAddresses = await remoteDataSource.getAddresses();
        // await localDataSource.cacheAddresses(remoteAddresses);
      }
      final addresses = await localDataSource.getAddresses();

      return Right(addresses.map((e) => e.toEntity()).toList());
    } catch (e) {
      try {
        final cached = await localDataSource.getAddresses();
        if (cached.isNotEmpty) {
          return Right(cached.map((e) => e.toEntity()).toList());
        }
        return Left(ServerFailure(
            'No internet and no cached data ${e.toString()}'));
      } catch (e) {
        return Left(
            CacheFailure( 'Failed to load cache ${e.toString()}'));
      }
    }
  }

  @override
  Future<Either<Failure, Unit>> addAddress(AddressEntity address) async {
   try {
      final model = AddressModel.fromEntity(address);

      if (await networkInfo.isConnected) {
        // await remoteDataSource.addAddress(model);
      }
      await localDataSource.addAddress(model);
      
      return const Right(unit);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> updateAddress(AddressEntity address) async {
    try {
      final model = AddressModel.fromEntity(address);
      if (await networkInfo.isConnected) {
        // await remoteDataSource.updateAddress(model);
      }
      await localDataSource.updateAddress(model);
      return const Right(unit);
    } catch (e) {
      return Left(CacheFailure( e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> setDefaultAddress(String id) async {
    try {
      if (await networkInfo.isConnected) {
        // await remoteDataSource.setDefaultAddress(id);
      }
      await localDataSource.setDefaultAddress(id);
      return const Right(unit);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteAddress(String id) async {
    try {
      if (await networkInfo.isConnected) {
        // await remoteDataSource.deleteAddress(id);
      }
      await localDataSource.deleteAddress(id);
      return const Right(unit);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<LabelAsEntity>>> getAddressType() async {
    await Future<void>.delayed(const Duration(milliseconds: 250));

    final List<LabelAsEntity> labelAsList = [
      LabelAsEntity('Home', Images.homeImage),
      LabelAsEntity('Office', Images.officeIcon),
      LabelAsEntity('Others', Images.address),
    ];
    return Right(labelAsList);
  }
}
