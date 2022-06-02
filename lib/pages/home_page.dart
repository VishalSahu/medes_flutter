// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medes/pages/home_appointment_form.dart';
import 'package:medes/pages/appointment_form.dart';
import 'package:medes/views/test_pack_info.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _username = '';
  User? user = FirebaseAuth.instance.currentUser;

  final userCollection = FirebaseFirestore.instance.collection('users');
  Future getUserData() async {
    try {
      DocumentSnapshot ds = await userCollection.doc(user!.uid).get();
      String name = ds.get('Name');
      setState(() {
        _username = name;
      });
    } catch (e) {
      _username = 'invalid';
    }
  }

  final List testPacks = [];
  Future getTestId() async {
    await FirebaseFirestore.instance
        .collection("testPack")
        .get()
        // ignore: avoid_function_literals_in_foreach_calls
        .then((snapshot) => snapshot.docs.forEach((element) {
              testPacks.add(element.reference.id);
            }));
  }

  @override
  void initState() {
    getTestId();
    getUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(top: 25, left: 25, right: 25),
      child: Column(
        children: [
          SizedBox(
            height: size.height / 2.7,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: size.height / 20,
                ),
                Text(
                  "Hi, $_username 👋",
                  style: GoogleFonts.poppins(
                      fontSize: 25,
                      color: Colors.black87,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: size.height / 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return AppointmentForm();
                            },
                          ),
                        );
                      },
                      child: Ink(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(0, 10),
                                blurRadius: 20,
                                color: Colors.deepPurple.withOpacity(0.5),
                              ),
                            ],
                            gradient: LinearGradient(
                              begin: Alignment.topRight,
                              end: Alignment.bottomLeft,
                              colors: const [
                                Color.fromARGB(255, 184, 149, 246),
                                Colors.deepPurple,
                              ],
                            ),
                            borderRadius: BorderRadius.circular(12)),
                        height: 150,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Icon(
                                Icons.add,
                                color: Colors.white,
                                size: 30,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                "Clinic Visit",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text("Make an appointment",
                                  style: TextStyle(
                                    color: Colors.white,
                                  )),
                            ]),
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return HomeAppointment();
                            },
                          ),
                        );
                      },
                      child: Ink(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(0, 10),
                                blurRadius: 20,
                                color: Colors.deepPurple.withOpacity(0.5),
                              ),
                            ],
                            color: Colors.blue,
                            gradient: LinearGradient(
                              begin: Alignment.topRight,
                              end: Alignment.bottomLeft,
                              colors: const [
                                Color.fromARGB(255, 184, 149, 246),
                                Colors.deepPurple,
                              ],
                            ),
                            borderRadius: BorderRadius.circular(12)),
                        height: 150,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Icon(
                              Icons.home,
                              color: Colors.white,
                              size: 30,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              "Home Visit",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "Call for home service",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Row(
            children: [
              Text(
                'Popular Test Kit',
                style: GoogleFonts.poppins(
                    fontSize: 18,
                    color: Colors.black87,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
          Expanded(
            child: NotificationListener<OverscrollIndicatorNotification>(
              onNotification: (overScroll) {
                overScroll.disallowIndicator();
                return true;
              },
              child: ListView.builder(
                  itemCount: testPacks.length,
                  itemBuilder: (context, index) {
                    return TestInfoCard(testId: testPacks[index]);
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
