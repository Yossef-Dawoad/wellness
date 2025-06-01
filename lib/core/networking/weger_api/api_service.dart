import 'package:dio/dio.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';
import 'package:wellness/features/login/data/models/login_response.dart';

import '../../../features/login/data/models/login_request_body.dart';
import '../../../features/register/data/models/register_request_body.dart';
import '../../../features/register/data/models/register_response.dart';
import '../../../features/routine/data/models/routine_response.dart';
import '../api_constants.dart';
part 'api_service.g.dart';

@RestApi(baseUrl: ApiConstants.apiBaseUrl)
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @POST(ApiConstants.accessTokenEP)
  Future<LoginResponse> login(@Body() LoginRequestBody loginRequestBody);

  @POST(ApiConstants.register)
  Future<RegisterResponse> register(@Body() RegisterRequestBody registerRequestBody);

  @GET(ApiConstants.getRoutine)
  Future<RoutineResponse> getRoutines();
}
