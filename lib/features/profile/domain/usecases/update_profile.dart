import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/profile_entity.dart';
import '../repositories/profile_repository.dart';

class UpdateProfileUseCase {
  UpdateProfileUseCase(this.repository);
  final ProfileRepository repository;

  Future<Either<Failure, ProfileEntity>> call(ProfileEntity profile) async =>
      await repository.updateProfile(profile);
}
