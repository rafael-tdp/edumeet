class ResetPasswordRequest {
  final String email;
  final String code;
  final String password;

  ResetPasswordRequest({
    required this.email,
    required this.code,
    required this.password
  });

  Map<String, dynamic> toJson() => {
    'email': email,
    'code': code,
    'password': password
  };
}