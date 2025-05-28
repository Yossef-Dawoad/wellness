import 'package:dio/dio.dart';

enum NetworkErrorType {
  timeout,
  unauthorized,
  badRequest,
  forbidden,
  notFound,
  serverError,
  noInternet,
  unknown,
}

class NetworkErrorHandler {
  static NetworkErrorType handle(dynamic error) {
    if (error is DioException) {
      if (error.type == DioExceptionType.connectionTimeout) {
        return NetworkErrorType.timeout;
      } else if (error.response?.statusCode == 401) {
        return NetworkErrorType.unauthorized;
      } else if (error.response?.statusCode == 400) {
        return NetworkErrorType.badRequest;
      } else if (error.response?.statusCode == 403) {
        return NetworkErrorType.forbidden;
      } else if (error.response?.statusCode == 404) {
        return NetworkErrorType.notFound;
      } else if (error.response?.statusCode == 500) {
        return NetworkErrorType.serverError;
      } else {
        return NetworkErrorType.unknown;
      }
    } else {
      return NetworkErrorType.unknown;
    }
  }
}