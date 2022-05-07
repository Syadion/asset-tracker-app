class User {
  String? email;
  String? password;

  User();

  Map<String, dynamic> toJson() => {'email': email, 'password': password};
}
