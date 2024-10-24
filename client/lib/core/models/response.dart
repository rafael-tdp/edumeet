import 'dart:convert';

ResponseRequest responseRequestFromJson(String str) => ResponseRequest.fromJson(json.decode(str));

String responseRequestToJson(ResponseRequest data) => json.encode(data.toJson());

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

  factory ResponseRequest.fromJson(Map<String, dynamic> json) =>
      ResponseRequest(
        success: json["success"],
        message: json["message"],
        errors: json["errors"],
        data: json["data"],
      );

  Map<String, dynamic> toJson() => {
    "message": message,
    "errors": errors,
    "data": data,
  };
}