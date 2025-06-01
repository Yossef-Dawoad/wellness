class RegisterResponse {
  final String? message;
  final String? token;

  RegisterResponse(this.message, this.token);

  factory RegisterResponse.fromJson(Map<String, dynamic> json) {
    return RegisterResponse(json['message'], json['token']);
  }
}
