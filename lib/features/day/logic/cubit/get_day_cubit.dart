import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/types/networking_error_types.dart';
import '../../data/repo/day_repo.dart';
import 'get_day_state.dart';

class GetDayCubit extends Cubit<GetDayState> {
  final DayRepo _dayRepo;
  GetDayCubit(this._dayRepo) : super(GetDayInitial());

  void emitGetDayStates() async {
    emit(GetDayLoading());

    final response = await _dayRepo.getDays();

    response.fold((error) {
      final errorType = NetworkErrorHandler.handle(error);
      final errorMessage = NetworkErrorHandler.getErrorMessage(errorType);
      emit(GetDayError(error: errorMessage));
    }, (response) => emit(GetDaySuccess(data: response)));
  }
}
