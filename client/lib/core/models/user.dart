class User {
  final String id;
  final String? email;
  final String? username;
  final String? lastname;
  final String? firstname;
  final String? password;
  final DateTime? birthDate;
  final String? bio;
  final String? picture;
  final bool activated;
  final int? reportNumber;
  final double? lng;
  final double? lat;
  final DateTime? createdAt;
  final String? role;

  User({
    required this.id,
    this.email,
    this.username,
    this.lastname,
    this.firstname,
    this.password,
    this.birthDate,
    this.bio,
    this.picture,
    this.activated = false,
    this.reportNumber,
    this.lng,
    this.lat,
    this.createdAt,
    this.role = 'USER'
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      email: json['email'],
      username: json['username'],
      lastname: json['lastname'],
      firstname: json['firstname'],
      password: json['password'],
      birthDate: json['birthDate'] != null ? DateTime.parse(json['birthDate']) : null,
      bio: json['bio'],
      picture: json['picture'],
      activated: json['activated'],
      reportNumber: json['reportNumber'],
      lng: json['lng']?.toDouble(),
      lat: json['lat']?.toDouble(),
      createdAt: DateTime.parse(json['created_at']),
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
      'password': password,
      'birthDate': birthDate?.toIso8601String(),
      'bio': bio,
      'picture': picture,
      'activated': activated,
      'reportNumber': reportNumber,
      'lng': lng,
      'lat': lat,
      'created_at': createdAt?.toIso8601String(),
      'role': role,
    };
  }
}