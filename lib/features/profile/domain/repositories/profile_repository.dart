import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/profile_entity.dart';

abstract class ProfileRepository {
  Future<Either<Failure, ProfileEntity>> getProfile();
  Future<Either<Failure, ProfileEntity>> updateProfile(ProfileEntity profile);
  Future<Either<Failure, String>> uploadAvatar(File image);
  Future<Either<Failure, Unit>> changePassword(String current, String newPassword);
  Future<Either<Failure, Unit>> logout();
  Future<Either<Failure, Unit>> deleteAccount();
}