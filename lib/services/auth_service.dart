import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  User? get currentUser => _firebaseAuth.currentUser;

  Future<User?> getOrCreateUser() async {
    if (currentUser != null) {
      return currentUser;
    } else {
      return null;
    }
  }

  //signOut
  Future<String> signOut() async {
    await _firebaseAuth.signOut();
    return 'sign Out sucessful';
  }
}
