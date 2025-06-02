
abstract class PostDayState {}

class PostDayInitial extends PostDayState {}

class PostDayLoading extends PostDayState {}

class PostDaySuccess<T> extends PostDayState {
  final T data;

  PostDaySuccess({required this.data});
}

class PostDayError extends PostDayState {
  final String error;

  PostDayError({required this.error});
}
