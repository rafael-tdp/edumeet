class SignupRequest {
  final String email;
  final String password;
  final String username;

  SignupRequest({required this.email, required this.password, required this.username});

  Map<String, dynamic> toJson() => {
    'email': email,
    'password': password,
    'username': username,
  };
}