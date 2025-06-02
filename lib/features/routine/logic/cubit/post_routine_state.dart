
abstract class PostRoutineState {}

class PostRoutineInitial extends PostRoutineState {}

class PostRoutineLoading extends PostRoutineState {}

class PostRoutineSuccess<T> extends PostRoutineState {
  final T data;

  PostRoutineSuccess({required this.data});
}

class PostRoutineError extends PostRoutineState {
  final String error;

  PostRoutineError({required this.error});
}
