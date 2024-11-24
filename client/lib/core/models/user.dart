import 'package:intl/intl.dart';

class User {
  final String id;
  final String email;
  final String username;
  final String lastname;
  final String firstname;
  final DateTime birthDate;
  final String? bio;
  final String? picture;
  final int? reportNumber;
  final String? address;
  final String? role;

  User({
    required this.id,
    required this.email,
    required this.username,
    required this.lastname,
    required this.firstname,
    required this.birthDate,
    this.bio,
    this.picture,
    this.reportNumber,
    this.address,
    this.role,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      email: json['email'],
      username: json['username'],
      lastname: json['lastname'],
      firstname: json['firstname'],
      birthDate: DateTime.parse(json['birthDate']),
      bio: json['bio'] ?? '',
      picture: json['picture'] ?? '',
      reportNumber: json['reportNumber'] ?? 0,
      address: json['address'],
      role: json['role'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'username': username,
      'lastname': lastname,
      'firstname': firstname,
      'birthDate': '${birthDate.toIso8601String()}Z',
      'bio': bio,
      'picture': picture,
      'reportNumber': reportNumber,
      'address': address,
      'role': role,
    };
  }
}