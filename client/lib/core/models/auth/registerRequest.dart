class RegisterRequest {
  final String email;
  final String password;
  final String username;
  final String firstname;
  final String lastname;
  final DateTime birthDate;
  final String address;

  RegisterRequest({
    required this.email,
    required this.password,
    required this.username,
    required this.firstname,
    required this.lastname,
    required this.birthDate,
    required this.address,
  });

  Map<String, dynamic> toJson() => {
    'email': email,
    'password': password,
    'username': username,
    'firstname': firstname,
    'lastname': lastname,
    'birthDate': '${birthDate.toIso8601String()}Z',
    'address': address,
  };
}