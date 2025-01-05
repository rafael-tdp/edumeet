import 'package:client/core/enums/FriendStatus.dart';

class FriendRequest {
  String id;
  String friendId;
  FriendStatus status;
  String friendUsername;

  FriendRequest({
    required this.id,
    required this.friendId,
    required this.status,
    required this.friendUsername,
  });

  factory FriendRequest.fromJson(Map<String, dynamic> json) {
    return FriendRequest(
      id: json['id'],
      friendId: json['friendID'],
      status: FriendStatus.values.firstWhere((e) => e.name.toUpperCase() == json['status'].toString().toUpperCase()),
      friendUsername: json['friendUsername'],
    );
  }
}