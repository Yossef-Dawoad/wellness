import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/types/networking_error_types.dart';
import '../../data/models/post_day_request_body.dart';
import '../../data/repo/day_repo.dart';
import 'post_day_state.dart';

class PostDayCubit extends Cubit<PostDayState> {
  final DayRepo _dayRepo;
  PostDayCubit(this._dayRepo) : super(PostDayInitial());

  void emitPostDayStates(PostDayRequestBody postDayRequestBody) async {
    emit(PostDayLoading());

    final response = await _dayRepo.addDay(postDayRequestBody);

    response.fold((error) {
      final errorType = NetworkErrorHandler.handle(error);
      final errorMessage = NetworkErrorHandler.getErrorMessage(errorType);
      emit(PostDayError(error: errorMessage));
    }, (response) => emit(PostDaySuccess(data: response)));
  }
}
