import 'package:dio/dio.dart';

class ServerException implements Exception {
  final String message;
  ServerException(this.message);

  factory ServerException.fromDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        return ServerException('Connection timeout with Api Server');
      case DioExceptionType.badResponse:
        return ServerException.fromResponse(e.response?.statusCode, e.response?.data);
      case DioExceptionType.unknown:
        if (e.message != null && e.message!.contains('SocketException')) {
          return ServerException('No Internet Connection');
        }
        return ServerException('Unexpected Error, Please try again!');
      default:
        return ServerException('Oops There was an Error, Please try again');
    }
  }

  factory ServerException.fromResponse(int? statusCode, dynamic response) {
    if (statusCode == 400 || statusCode == 401 || statusCode == 403) {
      return ServerException(response['error']['message'].toString());
    } else if (statusCode == 404) {
      return ServerException('Your request was not found, Please try later!');
    } else if (statusCode == 500) {
      return ServerException('There is a problem with the server, Please try later!');
    } else {
      return ServerException('Oops There was an Error, Please try again');
    }
  }
}

class CacheException implements Exception {}
class NetworkException implements Exception {
  NetworkException(this.message);

  final String message;
}

class ValidationException implements Exception {
  final Map<String, List<String>> errors;
  ValidationException(this.errors);
}
