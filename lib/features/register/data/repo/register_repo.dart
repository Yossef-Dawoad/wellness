import 'package:dartz/dartz.dart';
import 'package:wellness/core/networking/weger_api/api_service.dart';
import 'package:wellness/core/utils/types/networking_error_types.dart';
import 'package:wellness/core/utils/types/result_type.dart';
import 'package:wellness/features/register/data/models/register_request_body.dart';
import 'package:wellness/features/register/data/models/register_response.dart';

class RegisterRepo {
  final ApiService _apiService;

  RegisterRepo(this._apiService);

  Future<ApiResult<RegisterResponse>> register(
    RegisterRequestBody registerRequestBody,
  ) async {
    try {
      final response = await _apiService.register(registerRequestBody);
      return Right(response);
    } catch (error) {
      final errorHandled = NetworkErrorHandler.handle(error);
      return Left(errorHandled);
    }
  }
}
