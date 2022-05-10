import 'package:assettrackerapp/view/forgot_password_view.dart';
import 'package:assettrackerapp/view/user_registration_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //create the textfield controller
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future signIn() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
    } on FirebaseAuthException catch (e) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text(e.message.toString()),
            );
          });
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "assetTracker",
                    style: TextStyle(
                        color: Colors.blue,
                        fontSize: 44.0,
                        fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    "Sign in",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 28.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 44.0,
                  ),
                  TextField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      hintText: "User Email",
                      prefixIcon: Icon(
                        Icons.mail,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  TextField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      hintText: "User Password",
                      prefixIcon: Icon(
                        Icons.security,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 12.0,
                  ),
                  Row(children: [
                    GestureDetector(
                      onTap: (() {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return const ForgotPasswordScreen();
                            },
                          ),
                        );
                      }),
                      child: const Text(
                        "Don't Remember your Password?",
                        style: TextStyle(
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ]),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Column(
                    children: [
                      MaterialButton(
                        minWidth: double.infinity,
                        color: Colors.grey[600],
                        padding: const EdgeInsets.symmetric(vertical: 15.0),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0)),
                        onPressed: () async {
                          signIn();
                        },
                        child: const Text(
                          "Admin SignIn",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      MaterialButton(
                        minWidth: double.infinity,
                        color: Colors.grey[600],
                        padding: const EdgeInsets.symmetric(vertical: 15.0),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0)),
                        onPressed: () async {
                          signIn();
                        },
                        child: const Text(
                          "Public SignIn",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      MaterialButton(
                        minWidth: double.infinity,
                        color: Colors.grey[600],
                        padding: const EdgeInsets.symmetric(vertical: 15.0),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0)),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const UserRegistrationScreen()));
                        },
                        child: const Text(
                          "Register",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
