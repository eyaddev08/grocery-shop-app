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
