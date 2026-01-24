// عميل API الأساسي
// ملف مسؤول عن تهيئة Dio واستخدامه كعميل للشبكة.

import 'package:dio/dio.dart';
import '../../config/env/app_config.dart';

class ApiClient {
  final Dio dio;

  ApiClient(this.dio) {
    dio.options.baseUrl = AppConfig.fullApiUrl;
    dio.options.connectTimeout = const Duration(milliseconds: AppConfig.connectionTimeout);
    dio.options.receiveTimeout = const Duration(milliseconds: AppConfig.receiveTimeout);
    dio.options.headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
  }
}
