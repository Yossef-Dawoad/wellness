
abstract class RoutineState {}

class RoutineInitial extends RoutineState {}

class RoutineLoading extends RoutineState {}

class RoutineSuccess<T> extends RoutineState {
  final T data;

  RoutineSuccess({required this.data});
}

class RoutineError extends RoutineState {
  final String error;

  RoutineError({required this.error});
}