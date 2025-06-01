import 'package:dio/dio.dart';

enum NetworkErrorType {
  timeout,
  unauthorized,
  badRequest,
  forbiddenError,
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
        return NetworkErrorType.forbiddenError;
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

  static String getErrorMessage(NetworkErrorType errorType) {
    switch (errorType) {
      case NetworkErrorType.timeout:
        return "Connection timeout. Please try again.";
      case NetworkErrorType.unauthorized:
        return "Unauthorized. Please login again.";
      case NetworkErrorType.badRequest:
        return "Bad request. Please check your data.";
      case NetworkErrorType.forbiddenError:
        return "Access denied.";
      case NetworkErrorType.notFound:
        return "Data not found.";
      case NetworkErrorType.serverError:
        return "Server error. Please try again later.";
      case NetworkErrorType.noInternet:
        return "No internet connection.";
      case NetworkErrorType.unknown:
        return "An unknown error occurred.";
    }
  }
}