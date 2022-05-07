class UserModel {
  String? email;
  String? password;

  UserModel();

  Map<String, dynamic> toJson() => {'email': email, 'password': password};

  UserModel.fromSnapshot(snapshot)
      : email = snapshot.data()['email'],
        password = snapshot.data()['password'];
}
