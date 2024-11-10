class ResetPasswordRequest {
  final String plainPassword;
  final String confirmPassword;
  final String code;

  ResetPasswordRequest({
    required this.plainPassword,
    required this.confirmPassword,
    required this.code,
  });

  Map<String, dynamic> toJson() => {
    'plainPassword': plainPassword,
    'confirmPassword': confirmPassword,
    'code': code
  };
}