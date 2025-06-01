class LoginResponse {
  final String access;
  final String refresh;

  LoginResponse({required this.access, required this.refresh});

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      LoginResponse(access: json['access'], refresh: json['access']);
}
