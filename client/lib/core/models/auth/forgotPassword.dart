class ForgotPasswordRequest {
  final String email;

  ForgotPasswordRequest({required this.email});

  Map<String, dynamic> toJson() => {
    'email': email,
  };
}