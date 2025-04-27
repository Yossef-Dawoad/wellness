sealed class NetworkingError {
  const NetworkingError(this.error);
  final Exception error;
}

final class UnAuthenticatedError extends NetworkingError {
  UnAuthenticatedError(super.error);
}

final class UnKnownError extends NetworkingError {
  UnKnownError(super.error);
}

final class BadRequestError extends NetworkingError {
  BadRequestError(super.error);
}

final class NotFoundError extends NetworkingError {
  NotFoundError(super.error);
}
