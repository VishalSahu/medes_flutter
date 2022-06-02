import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterPage extends StatefulWidget {
  final VoidCallback showLoginPage;
  const RegisterPage({Key? key, required this.showLoginPage}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _nameController = TextEditingController();
  final _contactNumberController = TextEditingController();
  final _addressController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _nameController.dispose();
    _addressController.dispose();
    _contactNumberController.dispose();
    super.dispose();
  }

  Future signUp() async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
              child: CircularProgressIndicator(
            color: Colors.deepPurple,
          ));
        });
    //user register
    if (passwordConfirmed()) {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim());
    }
    User? user = FirebaseAuth.instance.currentUser;
    //user details
    addUserDetails(
      user!.uid,
      _nameController.text.trim(),
      _emailController.text.trim(),
      _addressController.text.trim(),
      _contactNumberController.text.trim(),
    );
    Navigator.of(context).pop();
  }

  User? user = FirebaseAuth.instance.currentUser;
  Future addUserDetails(String userId, String name, String email,
      String address, String phone) async {
    await FirebaseFirestore.instance.collection('users').doc(userId).set({
      'Name': name,
      'Email': email,
      'Address': address,
      'Phone_No': phone,
    });
  }

  bool passwordConfirmed() {
    if (_passwordController.text.trim() ==
        _confirmPasswordController.text.trim()) {
      return true;
    } else {
      return false;
    }
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
                    Text(
                      'Hello There!',
                      style: GoogleFonts.bebasNeue(fontSize: 54),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Register below with your details!',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(height: 50),
                    //Name Field
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 25,
                      ),
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please fill your name';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.name,
                        controller: _nameController,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.deepPurple),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          fillColor: Colors.grey[200],
                          filled: true,
                          hintText: 'Name',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),

                    //Address Field
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 25,
                      ),
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please fill your address';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.streetAddress,
                        controller: _addressController,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.deepPurple),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          fillColor: Colors.grey[200],
                          filled: true,
                          hintText: 'Address',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),

                    //Contact Number
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 25,
                      ),
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please fill your contact number';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.number,
                        controller: _contactNumberController,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.deepPurple),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          fillColor: Colors.grey[200],
                          filled: true,
                          hintText: 'Phone Number',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    //Email Field
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 25,
                      ),
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please fill your email ID';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.emailAddress,
                        controller: _emailController,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.deepPurple),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          fillColor: Colors.grey[200],
                          filled: true,
                          hintText: 'Email ID',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),

                    //password field
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 25,
                      ),
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please fill your password';
                          }
                          return null;
                        },
                        controller: _passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.deepPurple),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          fillColor: Colors.grey[200],
                          filled: true,
                          hintText: 'Password',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 25,
                      ),
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please repeat same password';
                          }
                          return null;
                        },
                        controller: _confirmPasswordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.deepPurple),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          fillColor: Colors.grey[200],
                          filled: true,
                          hintText: 'Confirm Password',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    //Login button
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 25,
                      ),
                      child: GestureDetector(
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            signUp();
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.deepPurple,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Center(
                            child: Text(
                              'Sign Up',
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
                    const SizedBox(
                      height: 25,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Already a member!',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        GestureDetector(
                          onTap: widget.showLoginPage,
                          child: const Text(
                            ' Login Now',
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
