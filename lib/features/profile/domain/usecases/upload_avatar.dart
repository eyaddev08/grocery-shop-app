import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../repositories/profile_repository.dart';

class UploadAvatarUseCase {
  UploadAvatarUseCase(this.repository);
  final ProfileRepository repository;

  Future<Either<Failure, String>> call(File image) async =>
      await repository.uploadAvatar(image);
}
