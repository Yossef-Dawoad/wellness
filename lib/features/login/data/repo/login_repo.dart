import 'package:dartz/dartz.dart';

import '../../../../core/networking/weger_api/api_service.dart';
import '../../../../core/utils/types/networking_error_types.dart';
import '../../../../core/utils/types/result_type.dart';
import '../models/login_request_body.dart';
import '../models/login_response.dart';

class LoginRepo {
  final ApiService _apiService;

  LoginRepo(this._apiService);

  Future<ApiResult<LoginResponse>> login(
    LoginRequestBody loginRequestBody,
  ) async {
    try {
      final response = await _apiService.login(loginRequestBody);
      return Right(response);
    } catch (error) {
      final handledError = NetworkErrorHandler.handle(error);
      return Left(handledError);
    }
  }
}
