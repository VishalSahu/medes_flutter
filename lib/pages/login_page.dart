// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medes/pages/forgot_pw_page.dart';

class LoginPage extends StatefulWidget {
  final VoidCallback showRegisterPage;

  const LoginPage({Key? key, required this.showRegisterPage}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isHidden = true;

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Future signIn() async {
    showDialog(
        context: context,
        builder: (context) {
          return Center(
              child: CircularProgressIndicator(
            color: Colors.deepPurple,
          ));
        });
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('${e.message}'),
      ));
    }
    Navigator.of(context, rootNavigator: true).pop();
  }

  void _togglePasswordView() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/logo/logo.png',
                      height: 100,
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Text(
                      'Hello Again!',
                      style: GoogleFonts.bebasNeue(fontSize: 54),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Welcome back, you\'ve been missed!',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(height: 50),

                    //Email Field
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 25,
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: TextFormField(
                            controller: _emailController,
                            decoration: InputDecoration(
                              hintText: 'Email ID',
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),

                    //password field
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 25,
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: TextFormField(
                            controller: _passwordController,
                            obscureText: _isHidden,
                            decoration: InputDecoration(
                              suffix: InkWell(
                                onTap: _togglePasswordView,
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 20),
                                  child: Icon(
                                    _isHidden
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                              hintText: 'Password',
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return ForgotPasswordPage();
                                  },
                                ),
                              );
                            },
                            child: Text(
                              "Forgot Password",
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),

                    //Login button
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 25,
                      ),
                      child: GestureDetector(
                        onTap: signIn,
                        child: Container(
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Color(0xFF673AB7),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Center(
                            child: Text(
                              'Sign In',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Not a member?',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        GestureDetector(
                          onTap: widget.showRegisterPage,
                          child: Text(
                            ' Register Now',
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
