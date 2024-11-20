class ValidateAccountRequest {
  final String email;
  final String code;

  ValidateAccountRequest({
    required this.email,
    required this.code,
  });

  Map<String, dynamic> toJson() => {
    'email': email,
    'code': code
  };
}