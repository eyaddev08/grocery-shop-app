import 'package:dio/dio.dart';

abstract class Failure {
  final String message;
  Failure(this.message);
}

class ServerFailure extends Failure {
  ServerFailure(super.message);
}

class CacheFailure extends Failure {
  CacheFailure(super.message);
}

class NetworkFailure extends Failure {
  NetworkFailure(super.message);
}


class ValidationFailure extends Failure {
  ValidationFailure({required String message, required this.errors}) : super(message);
  final Map<String, List<String>> errors;
}
