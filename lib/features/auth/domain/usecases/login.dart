// ملف مسؤول عن حالة الاستخدام لتسجيل الدخول.

import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../entities/auth_token.dart';
import '../repositories/auth_repository.dart';

class Login {

  Login(this.repository);
  final AuthRepository repository;

  Future<Either<Failure, AuthToken>> call(String email, String password) => repository.login(email, password);
}

