// ملف مسؤول عن حالة الاستخدام لتسجيل مستخدم جديد.

import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../entities/user.dart';
import '../repositories/auth_repository.dart';

class Register {

  Register(this.repository);
  final AuthRepository repository;

  Future<Either<Failure, User>> call({
    required String name,
    required String email,
    required String password,
    required String passwordConfirmation,
  }) => repository.register(
      name: name,
      email: email,
      password: password,
      passwordConfirmation: passwordConfirmation,
    );
}

