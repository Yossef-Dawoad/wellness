abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess<T> extends LoginState {
  final T data;

  LoginSuccess({required this.data});
}

class LoginError extends LoginState {
  final String error;

  LoginError({required this.error});
}
