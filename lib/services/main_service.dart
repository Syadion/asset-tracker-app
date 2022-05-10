import 'package:assettrackerapp/view/login_view.dart';
import 'package:assettrackerapp/view/main_menu_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthCheck extends StatelessWidget {
  const AuthCheck({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return MenuScreen();
          } else {
            return LoginScreen();
          }
        },
      ),
    );
  }
}
