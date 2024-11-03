class ResetPasswordRequest {
  final String plainPassword;
  final String confirmPassword;

  ResetPasswordRequest({
    required this.plainPassword,
    required this.confirmPassword,
  });

  Map<String, dynamic> toJson() => {
    'plainPassword': plainPassword,
    'confirmPassword': confirmPassword,
  };
}