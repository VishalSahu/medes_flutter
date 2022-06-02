import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medes/model/appointments_data.dart';

class AppointmentList extends StatefulWidget {
  const AppointmentList({Key? key}) : super(key: key);

  @override
  State<AppointmentList> createState() => _AppointmentListState();
}

class _AppointmentListState extends State<AppointmentList> {
  User? user = FirebaseAuth.instance.currentUser;
  List<String> docIDs = [];
  Future getDocIds() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .collection('appointments')
        .get()
        // ignore: avoid_function_literals_in_foreach_calls
        .then((snapshot) => snapshot.docs.forEach((element) {
              docIDs.add(element.reference.id);
            }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  left: 25, right: 25, bottom: 10, top: 25),
              child: Text(
                "Appointments",
                style: GoogleFonts.raleway(
                    fontSize: 24,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: FutureBuilder(
                future: getDocIds(),
                builder: (context, snapshot) {
                  return ListView.builder(
                    itemCount: docIDs.length,
                    itemBuilder: (context, index) {
                      return AppointmentData(documentId: docIDs[index]);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
