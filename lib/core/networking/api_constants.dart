class ApiConstants {
  static const String accessToken =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzQ4MzUxOTE3LCJpYXQiOjE3NDgzNTEzMTcsImp0aSI6IjcyZGJkODE0Mzc5MTRkYjRhMGZjYjMyYzY0MjRlODliIiwidXNlcl9pZCI6MTcwMzM1fQ.P7hgRmSIowGbLSvhgDG6EkY5lgAUSRyruvpsv8qTbIM';
  static const String refreshToken =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc0ODQzNzcxNywiaWF0IjoxNzQ4MzUxMzE3LCJqdGkiOiIzMDQ2ZmUxMDI4NmU0ZTAzYTA2ZGYxZTU0ZWU3NTMwMiIsInVzZXJfaWQiOjE3MDMzNX0.K9pe9A39q0K2kvtULC2T7n3T0D_67gGrhQ1irZZbwqw';
  static const String apiBaseUrl = 'https://wger.de/api/v2/';
  static const String refreshTokenEP = 'token/refresh';
  static const String accessTokenEP = 'token';
  static const String register = 'register/';
  static const String addRoutine = 'routine/';
  static const String getRoutine = 'routine/?is_public=false';
}

class ApiErrors {
  static const String badRequestError = "badRequestError";
  static const String noContent = "noContent";
  static const String forbiddenError = "forbiddenError";
  static const String unauthorizedError = "unauthorizedError";
  static const String notFoundError = "notFoundError";
  static const String conflictError = "conflictError";
  static const String internalServerError = "internalServerError";
  static const String unknownError = "unknownError";
  static const String timeoutError = "timeoutError";
  static const String defaultError = "defaultError";
  static const String cacheError = "cacheError";
  static const String noInternetError = "noInternetError";
  static const String loadingMessage = "loading_message";
  static const String retryAgainMessage = "retry_again_message";
  static const String ok = "Ok";
}
