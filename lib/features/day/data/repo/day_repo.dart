import 'package:dartz/dartz.dart';

import '../../../../core/networking/weger_api/api_service.dart';
import '../../../../core/utils/types/networking_error_types.dart';
import '../../../../core/utils/types/result_type.dart';
import '../models/get_day_response.dart';
import '../models/post_day_request_body.dart';
import '../models/post_day_response.dart';

class DayRepo {
  final ApiService _apiService;

  DayRepo(this._apiService);

  Future<ApiResult<GetDayResponse>> getDays() async {
    try {
      final response = await _apiService.getDays();
      return Right(response);
    } catch (error) {
      final errorHandled = NetworkErrorHandler.handle(error);
      return Left(errorHandled);
    }
  }

  Future<ApiResult<PostDayResponse>> addDay(PostDayRequestBody postDayRequestBody) async {
    try {
      final response = await _apiService.addDay(postDayRequestBody);
      return Right(response);
    } catch (error) {
      final errorHandled = NetworkErrorHandler.handle(error);
      return Left(errorHandled);
    }
  }
}
