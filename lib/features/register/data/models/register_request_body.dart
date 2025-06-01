class RegisterRequestBody {
  final String userName;
  final String password;
  final String email;

  RegisterRequestBody({
    required this.userName,
    required this.password,
    required this.email,
  });

  Map<String, dynamic> toJson() {
    return {'username': userName, 'password': password, 'email': email};
  }
}
