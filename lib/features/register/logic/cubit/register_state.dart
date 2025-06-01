abstract class RegisterState {}

class RegisterInitial extends RegisterState {}

class RegisterLoading extends RegisterState {}

class RegisterSuccess<T> extends RegisterState {
  final T data;

  RegisterSuccess({required this.data});
}

class RegisterError extends RegisterState {
  final String error;

  RegisterError({required this.error});
}
