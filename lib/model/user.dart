class User {
  String? userId;
  String? email;
  String? password;

  User();

  Map<String, dynamic> toJson() =>
      {'user id': userId, 'email': email, 'password': password};
}
