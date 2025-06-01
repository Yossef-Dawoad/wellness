import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:wellness/core/networking/api_constants.dart';

import 'auth_interceptor.dart';

class DioFactory {
  /// Private Constructor as I don't want to allow creating an instance from this class
  DioFactory._();

  static Dio? dio;

  
  static Dio getDio() {
    Duration timeOut = Duration(seconds: 30);

    if (dio == null) {
      // create new instance
      dio = Dio();
      dio!
        ..options.baseUrl = ApiConstants.apiBaseUrl
        ..options.connectTimeout = timeOut
        ..options.receiveTimeout = timeOut
        ..options.contentType = 'application/json';

      addDioInerceptor();
      return dio!;
    } else {
      return dio!;
    }
  }

  static addDioInerceptor() {
    
    dio!.interceptors.addAll([
      PrettyDioLogger(
        requestBody: true,
        requestHeader: true,
        responseHeader: true,
      ),
      AuthInterceptor(),
    ]
    );
  }

  /// Clean dio without interceptors (used for refresh token)
  static Dio get cleanDio => Dio(
  BaseOptions(
    baseUrl: ApiConstants.apiBaseUrl,
    connectTimeout: Duration(seconds: 30),
    receiveTimeout: Duration(seconds: 30),
    contentType: 'application/json',
  ),
);
}
