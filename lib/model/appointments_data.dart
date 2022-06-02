import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppointmentData extends StatelessWidget {
  const AppointmentData({Key? key, required this.documentId}) : super(key: key);
  final String documentId;
  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    CollectionReference appointments = FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .collection('appointments');
    return FutureBuilder<DocumentSnapshot>(
      future: appointments.doc(documentId).get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          // Timestamp timestamp = data['appointment_date_time'];
          // DateTime myDateTime = timestamp.toDate();
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(0, 10),
                    blurRadius: 20,
                    color: Colors.deepPurple.withOpacity(0.15),
                  ),
                ],
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.deepPurple,
                    Color.fromARGB(255, 53, 22, 107),
                  ],
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.person,
                              size: 18,
                              color: Colors.white,
                            ),
                            Text(
                              ' ${data['name']}',
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.w300,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            '${data['date']}',
                            style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.w300,
                                color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.medical_services,
                          size: 18,
                          color: Colors.white,
                        ),
                        Text(
                          ' ${data['test-type']}',
                          style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w300,
                              color: Colors.white),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.pin_drop,
                          size: 18,
                          color: Colors.white,
                        ),
                        Text(
                          ' ${data['address']}',
                          style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w300,
                              color: Colors.white),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.phone,
                            size: 18,
                            color: Colors.white,
                          ),
                          Text(
                            ' ${data['contact_info']}',
                            style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.w300,
                                color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
          );
        }
        return const Text("Loading your appointments !");
      },
    );
  }
}
