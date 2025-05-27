import 'package:dio/dio.dart';
import 'package:wellness/core/networking/api_constants.dart';
import 'package:wellness/core/networking/weger_api/dio_factory.dart';

import 'token_manager.dart';

class AuthInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final token = await TokenManager.getAccessToken();

    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    return handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401 && !_isRefreshingToken(err)) {
      final refreshToken = await TokenManager.getRefreshToken();

      if (refreshToken != null) {
        try {
          final dio = DioFactory.cleanDio;

          final response = await dio.post(
            ApiConstants.refreshTokenEP,
            data: {'refresh': refreshToken},
          );

          final newAccessToken = response.data['access'];
          await TokenManager.updateAccessToken(newAccessToken);

          // Retry original request
          final cloneRequest = err.requestOptions;
          cloneRequest.headers['Authorization'] = 'Bearer $newAccessToken';

          final retryResponse = await dio.fetch(cloneRequest);
          return handler.resolve(retryResponse);
        } catch (e) {
          await TokenManager.clearTokens();
          return handler.reject(
            DioException(
              requestOptions: err.requestOptions,
              error: 'Session expired. Please login again.',
              type: DioExceptionType.badResponse,
            ),
          );
        }
      }
    }

    return handler.next(err);
  }

  bool _isRefreshingToken(DioException err) {
    return err.requestOptions.path.contains(ApiConstants.refreshTokenEP);
  }
}