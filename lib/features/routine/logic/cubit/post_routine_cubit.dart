import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wellness/features/routine/data/repo/routine_repo.dart';

import '../../../../core/utils/types/networking_error_types.dart';
import '../../data/models/post_routine_request_body.dart';
import 'post_routine_state.dart';

class PostRoutineCubit extends Cubit<PostRoutineState> {
  final RoutineRepo _repo;
  PostRoutineCubit(this._repo) : super(PostRoutineInitial());

  void emitPostRoutineStates(
    PostRoutineRequestBody postRoutineRequestBody,
  ) async {
    emit(PostRoutineLoading());

    final response = await _repo.addRoutine(postRoutineRequestBody);

    response.fold((error) {
      final errorType = NetworkErrorHandler.handle(error);
      final errorMessage = NetworkErrorHandler.getErrorMessage(errorType);
       emit(PostRoutineError(error: errorMessage));
    }, (response) => emit(PostRoutineSuccess(data: response)));
  }
}
