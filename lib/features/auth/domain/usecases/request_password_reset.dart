// ملف مسؤول عن حالة الاستخدام لطلب إعادة تعيين كلمة المرور.

import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../repositories/auth_repository.dart';

class RequestPasswordReset {

  RequestPasswordReset(this.repository);
  final AuthRepository repository;

  Future<Either<Failure, void>> call(String email) => repository.requestPasswordReset(email);
}

