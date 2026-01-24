// فئات الأخطاء في التطبيق
class Failure {
  final String message;
  Failure(this.message);

  @override
  String toString() => 'Failure(message: $message)';
}

class ServerFailure extends Failure {
  ServerFailure({required String message}) : super(message);
}

class CacheFailure extends Failure {
  CacheFailure({required String message}) : super(message);
}

class NetworkFailure extends Failure {
  NetworkFailure({required String message}) : super(message);
}

class ValidationFailure extends Failure {
  final Map<String, List<String>> errors;
  ValidationFailure({required String message, required this.errors}) : super(message);
}
