class ResponseRequest {
  final bool success;
  final String? message;
  final String? errors;
  final dynamic data;

  ResponseRequest({
    required this.success,
    this.message,
    this.errors,
    this.data,
  });
}