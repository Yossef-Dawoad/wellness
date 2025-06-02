
abstract class GetDayState {}

class GetDayInitial extends GetDayState {}

class GetDayLoading extends GetDayState {}

class GetDaySuccess<T> extends GetDayState {
  final T data;

  GetDaySuccess({required this.data});
}

class GetDayError extends GetDayState {
  final String error;

  GetDayError({required this.error});
}