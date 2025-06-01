import 'package:dartz/dartz.dart';
import 'package:wellness/core/networking/weger_api/api_service.dart';
import 'package:wellness/core/utils/types/result_type.dart';
import 'package:wellness/features/routine/data/models/routine_response.dart';

import '../../../../core/utils/types/networking_error_types.dart';

class RoutineRepo {
  final ApiService _apiService;

  RoutineRepo(this._apiService);

  Future<ApiResult<RoutineResponse>> getRoutines() async {
    try {
      final response = await _apiService.getRoutines();
      return Right(response);
    } catch (error) {
      final handledError = NetworkErrorHandler.handle(error);
      return Left(handledError);
    }
  }
}
