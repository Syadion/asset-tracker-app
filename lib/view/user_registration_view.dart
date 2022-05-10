import 'package:assettrackerapp/model/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserRegistrationScreen extends StatefulWidget {
  const UserRegistrationScreen({Key? key}) : super(key: key);

  @override
  State<UserRegistrationScreen> createState() => _UserRegistrationScreenState();
}

class _UserRegistrationScreenState extends State<UserRegistrationScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final UserModel _userModel = UserModel();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Register User'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
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
              height: 44.0,
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
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MaterialButton(
                    child: const Text('Register'),
                    color: Colors.grey,
                    onPressed: () {
                      registerUser();
                      _saveUser();
                      const AlertDialog(title: Text('registration successful'));
                    }),
                MaterialButton(
                    child: const Text('Cancel'),
                    color: Colors.grey,
                    onPressed: () {
                      Navigator.of(context).pop();
                    }),
              ],
            )
          ],
        ),
      ),
    );
  }

  Future registerUser() async {
    /*showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(
              child: CircularProgressIndicator(),
            ));*/
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text, password: _passwordController.text);
    } on FirebaseAuthException catch (e) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text(e.message.toString()),
            );
          });
      //navigatorKey.currentState!.popUntil((route) =>);
    }
  }

  void _saveUser() async {
    _userModel.email = _emailController.text;
    _userModel.password = _passwordController.text;

    await FirebaseFirestore.instance
        .collection('userData')
        .add(_userModel.toJson());
  }
}
