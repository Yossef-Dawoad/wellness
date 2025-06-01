import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wellness/features/routine/data/repo/routine_repo.dart';

import '../../../../core/utils/types/networking_error_types.dart';
import 'routine_state.dart';

class RoutineCubit extends Cubit<RoutineState> {
  final RoutineRepo _repo;
  RoutineCubit(this._repo) : super(RoutineInitial());

  void emitGetRoutineStates() async {
    emit(RoutineLoading());

    final response = await _repo.getRoutines();
    response.fold((error) {
      final errorType = NetworkErrorHandler.handle(error);
      final errorMessage = NetworkErrorHandler.getErrorMessage(errorType);
      emit(RoutineError(error: errorMessage));
    }, (response) => emit(RoutineSuccess(data: response)));
  }
}
