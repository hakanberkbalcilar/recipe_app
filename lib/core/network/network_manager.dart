import 'package:recipe_app/core/constants/app_constants.dart';
import 'package:recipe_app/core/network/interceptors/log_interceptor.dart';
import 'package:dio/dio.dart' hide LogInterceptor;
import 'package:dio/io.dart';
import 'package:flutter/foundation.dart';

class NetworkManager extends DioMixin {
  static NetworkManager? _instance;
  static NetworkManager get instance => _instance ?? (_instance = NetworkManager._init());

  NetworkManager._init() {
    options = BaseOptions(baseUrl: baseUrl, headers: baseHeader);

    if (!kIsWeb) {
      httpClientAdapter = IOHttpClientAdapter()..onHttpClientCreate = (client) => client..badCertificateCallback = (cert, host, port) => true;
    }

    interceptors.add(LogInterceptor());
  }
}
