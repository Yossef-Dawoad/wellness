sealed class Result<T, R> {
  const Result();

  factory Result.ok(T value) => OK(value);
  factory Result.error(R error) => Error(error);
  bool get isOK => this is OK;
  bool get isError => this is Error;
}

final class OK<T, R> extends Result<T, R> {
  final T value;
  const OK(this.value);
}

final class Error<T, R> extends Result<T, R> {
  final R error;
  const Error(this.error);
}
