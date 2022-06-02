import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  User? user = FirebaseAuth.instance.currentUser;
  String _username = '';
  String _userEmail = '';
  String _userAddress = '';
  String _userMobileNo = '';
  final userCollection = FirebaseFirestore.instance.collection('users');
  Future getUserData() async {
    try {
      DocumentSnapshot ds = await userCollection.doc(user!.uid).get();

      String name = ds.get('Name');
      String address = ds.get('Address');
      String email = ds.get('Email');
      String phoneNo = ds.get('Phone_No');
      setState(() {
        _username = name;
        _userAddress = address;
        _userEmail = email;
        _userMobileNo = phoneNo;
      });
    } catch (e) {
      _username = 'invalid';
    }
  }

  @override
  void initState() {
    getUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController()
      ..text = _username;
    TextEditingController emailController = TextEditingController()
      ..text = _userEmail;
    TextEditingController addressController = TextEditingController()
      ..text = _userAddress;
    TextEditingController phoneController = TextEditingController()
      ..text = _userMobileNo;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 250,
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color.fromARGB(255, 152, 95, 250),
                  Colors.deepPurple,
                ],
              )),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: Text(
                    nameController.text,
                    style:
                        GoogleFonts.raleway(fontSize: 35, color: Colors.white),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 60,
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(4),
                        child: Text(
                          'My Email :',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            color: Colors.deepPurple[500],
                          ),
                        ),
                      ),
                    ],
                  ),
                  TextField(
                    keyboardType: TextInputType.name,
                    controller: emailController,
                    readOnly: true,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      fillColor: Colors.grey[200],
                      filled: true,
                      border: InputBorder.none,
                    ),
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(4),
                        child: Text(
                          'My Address :',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            color: Colors.deepPurple[500],
                          ),
                        ),
                      ),
                    ],
                  ),
                  TextField(
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                    ),
                    maxLines: null,
                    keyboardType: TextInputType.name,
                    controller: addressController,
                    readOnly: true,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      fillColor: Colors.grey[200],
                      filled: true,
                      border: InputBorder.none,
                    ),
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(4),
                        child: Text(
                          'My Contact Number :',
                          style: GoogleFonts.poppins(
                            color: Colors.deepPurple[500],
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                  TextField(
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                    ),
                    keyboardType: TextInputType.name,
                    controller: phoneController,
                    readOnly: true,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      fillColor: Colors.grey[200],
                      filled: true,
                      border: InputBorder.none,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4),
                    child: Text(
                      '*To change user details, email us at users@medes.com',
                      style: GoogleFonts.poppins(
                        color: Colors.grey[500],
                        fontSize: 14,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 100,
                    ),
                    child: GestureDetector(
                      onTap: () {
                        FirebaseAuth.instance.signOut();
                      },
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.deepPurple,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              offset: const Offset(0, 10),
                              blurRadius: 50,
                              color: Colors.deepPurple.withOpacity(0.23),
                            ),
                          ],
                        ),
                        child: const Center(
                          child: Text(
                            'Logout',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
