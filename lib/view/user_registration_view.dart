import 'package:assettrackerapp/model/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserRegitrationScreen extends StatefulWidget {
  const UserRegitrationScreen({Key? key}) : super(key: key);

  @override
  State<UserRegitrationScreen> createState() => _UserRegitrationScreenState();
}

class _UserRegitrationScreenState extends State<UserRegitrationScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final UserModel _userModel = UserModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register User'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            children: [
              TextField(controller: _emailController),
              const SizedBox(
                height: 18.0,
              ),
              TextField(
                controller: _passwordController,
                obscureText: true,
              ),
              const SizedBox(
                height: 18.0,
              ),
              Row(
                children: [
                  ElevatedButton(
                      child: const Text('Register'),
                      onPressed: () {
                        registerUser();
                        _saveUser();
                      }),
                  ElevatedButton(child: Text('Cancel'), onPressed: () {}),
                ],
              )
            ],
          ),
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
      print(e);
    }
    //navigatorKey.currentState!.popUntil((route) =>);
  }

  void _saveUser() async {
    _userModel.email = _emailController.text;
    _userModel.password = _passwordController.text;

    await FirebaseFirestore.instance
        .collection('userData')
        .add(_userModel.toJson());
  }
}
