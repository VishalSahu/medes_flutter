// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future passwordReset() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: _emailController.text.trim());
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Password reset link sent! check your email'),
      ));
    } on FirebaseException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('${e.message}'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple[200],
        elevation: 0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: Text(
              'Enter your email and we will send you a password reset link.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 25,
            ),
            child: TextField(
              controller: _emailController,
              decoration: InputDecoration(
                hintText: 'Email ID',
                filled: true,
                fillColor: Colors.grey[200],
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Color(0xFF673AB7)),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          MaterialButton(
            child: Text('Reset Password'),
            color: Colors.deepPurple[200],
            onPressed: passwordReset,
          ),
        ],
      ),
    );
  }
}
