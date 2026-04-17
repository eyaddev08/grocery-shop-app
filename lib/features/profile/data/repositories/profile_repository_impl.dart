import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../../core/error/exception.dart';
import '../../../../core/error/failure.dart';
import '../../domain/entities/profile_entity.dart';
import '../../domain/repositories/profile_repository.dart';
import '../datasources/profile_local_data_source.dart';
import '../datasources/profile_remote_data_source.dart';
import '../models/profile_model.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  ProfileRepositoryImpl(this.remoteDataSource, this.localDataSource);
  final ProfileRemoteDataSource remoteDataSource;
  final ProfileLocalDataSource localDataSource;

  @override
  Future<Either<Failure, ProfileEntity>> getProfile() async {
    try {
      // Cache-first strategy ensuring mock updates persist between restarts!
      final cached = await localDataSource.getCachedProfile();
      if (cached != null) {
        return Right(cached);
      }
      final remoteProfile = await remoteDataSource.getProfile();
      await localDataSource.cacheProfile(remoteProfile);
      return Right(remoteProfile);
    } on ServerException catch (e) {
      final cached = await localDataSource.getCachedProfile();
      if (cached != null) {
        return Right(cached);
      }
      return Left(ServerFailure( e.message ?? ''));
    }
  }

  @override
  Future<Either<Failure, ProfileEntity>> updateProfile(
      ProfileEntity profile) async {
    try {
      final profileModel = ProfileModel(
        id: profile.id,
        name: profile.name,
        email: profile.email,
        phone: profile.phone,
        address: profile.address,
        avatarUrl: profile.avatarUrl,
        createdAt: profile.createdAt,
      );
      final updated = await remoteDataSource.updateProfile(profileModel);
      await localDataSource.cacheProfile(updated);
      return Right(updated);
    } on ServerException catch (e) {
      return Left(ServerFailure( e.message ?? ''));
    }
  }

  @override
  Future<Either<Failure, String>> uploadAvatar(File image) async {
    try {
      final avatarUrl = await remoteDataSource.uploadAvatar(image);
      final cached = await localDataSource.getCachedProfile();
      if (cached != null) {
        final updated = ProfileModel(
          id: cached.id,
          name: cached.name,
          email: cached.email,
          phone: cached.phone,
          address: cached.address,
          avatarUrl: avatarUrl,
          createdAt: cached.createdAt,
        );
        await localDataSource.cacheProfile(updated);
      }
      return Right(avatarUrl);
    } on ServerException catch (e) {
      return Left(ServerFailure( e.message ?? ''));
    }
  }

  @override
  Future<Either<Failure, Unit>> changePassword(
      String current, String newPassword) async {
    try {
      await remoteDataSource.changePassword(current, newPassword);
      return const Right(unit);
    } on ServerException catch (e) {
      return Left(ServerFailure( e.message ?? ''));
    }
  }

  @override
  Future<Either<Failure, Unit>> logout() async {
    try {
      await remoteDataSource.logout();
      await localDataSource.clearCache();
      return const Right(unit);
    } on ServerException catch (e) {
      return Left(ServerFailure( e.message ?? ''));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteAccount() async {
    try {
      await remoteDataSource.deleteAccount();
      await localDataSource.clearCache();
      return const Right(unit);
    } on ServerException catch (e) {
      return Left(ServerFailure( e.message ?? ''));
    }
  }
}
