class RegisterRequest {
  final String email;
  final String password;
  final String username;
  final String zipCode;

  RegisterRequest({
    required this.email,
    required this.password,
    required this.username,
    required this.zipCode
  });

  Map<String, dynamic> toJson() => {
    'email': email,
    'password': password,
    'username': username,
    'address': zipCode,
  };
}