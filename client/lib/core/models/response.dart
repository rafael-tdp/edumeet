import 'dart:convert';

ResponseRequest responseRequestFromJson(String str) => ResponseRequest.fromJson(json.decode(str));

String responseRequestToJson(ResponseRequest data) => json.encode(data.toJson());

class ResponseRequest {
  final String message;
  final String status;

  ResponseRequest({
    required this.message,
    required this.status,
  });

  factory ResponseRequest.fromJson(Map<String, dynamic> json) =>
      ResponseRequest(
        message: json["message"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
    "message": message,
    "status": status,
  };
}