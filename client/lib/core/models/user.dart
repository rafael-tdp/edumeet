import 'package:client/core/models/badge.dart';
import 'package:diacritic/diacritic.dart';

class User {
  final String? id;
  final String? email;
  final String username;
  final String? lastname;
  final String? firstname;
  final DateTime? birthDate;
  final String? bio;
  final String? picture;
  final int? reportNumber;
  final String? address;
  final String? role;
  final bool? activated;
  final List<Badge>? badges;
  final int? nbFriends;
  final int? nbParticpatedEvents;
  final bool IsMyFriend;

  User({
    required this.id,
    this.email,
    required this.username,
    this.lastname,
    this.firstname,
    this.birthDate,
    this.bio,
    this.picture,
    this.reportNumber,
    this.address,
    this.role,
    this.activated,
    this.badges,
    this.nbFriends,
    this.nbParticpatedEvents,
    this.IsMyFriend = false,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    var bd = json['birthDate'] ?? '';
    var birthDate = bd.endsWith('ZZ')
        ? DateTime.parse(bd.substring(0, bd.length - 1))
        : DateTime.parse(bd);
    return User(
      id: json['id'] ?? '',
      email: json['email'] ?? '',
      username: json['username'],
      lastname: json['lastname'] ?? '',
      firstname: json['firstname'] ?? '',
      birthDate: birthDate,
      bio: json['bio'] ?? '',
      picture: json['picture'] ?? '',
      reportNumber: json['reportNumber'] ?? 0,
      address: json['address'],
      role: json['role'],
      activated: json['activated'],
      badges: json['badges'] != null ? (json['badges'] as List).map((badge) => Badge.fromJson(badge)).toList() : null,
      nbFriends: json['nbFriends'] ?? 0,
      nbParticpatedEvents: json['nbParticipatedEvents'] ?? 0,
      IsMyFriend: json['isMyFriend'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'username': username,
      'lastname': lastname,
      'firstname': firstname,
      'birthDate': birthDate != null
          ? (birthDate!.toIso8601String().endsWith('Z')
              ? birthDate!.toIso8601String()
              : '${birthDate!.toIso8601String()}Z')
          : null,
      'bio': bio,
      'picture': picture,
      'reportNumber': reportNumber,
      'address': removeDiacritics(address!),
      'role': role,
      'activated': activated
    };
  }
}
