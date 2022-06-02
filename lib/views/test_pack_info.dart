import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medes/views/alertpage_for_test.dart';

// ignore: must_be_immutable
class TestInfoCard extends StatefulWidget {
  String testId;
  TestInfoCard({Key? key, required this.testId}) : super(key: key);

  @override
  State<TestInfoCard> createState() => _TestInfoCardState();
}

class _TestInfoCardState extends State<TestInfoCard> {
  @override
  Widget build(BuildContext context) {
    CollectionReference testInfo =
        FirebaseFirestore.instance.collection('testPack');

    return FutureBuilder<DocumentSnapshot>(
        future: testInfo.doc(widget.testId).get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
            return Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        offset: const Offset(0, 5),
                        blurRadius: 20,
                        color: Colors.deepPurple.withOpacity(0.1),
                      ),
                    ],
                    borderRadius: BorderRadius.circular(12)),
                height: 150,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        width: 125,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 16,
                            ),
                            Text(
                              data['name'],
                              style: GoogleFonts.nunito(
                                  fontSize: 20,
                                  color: const Color(0xff050a4e),
                                  fontWeight: FontWeight.w700),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                const FaIcon(
                                  FontAwesomeIcons.flaskVial,
                                  color: Colors.deepPurple,
                                  size: 14,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Flexible(
                                  child: Text(
                                    data['description'],
                                    softWrap: true,
                                    maxLines: 2,
                                    style: GoogleFonts.nunito(
                                        fontSize: 16,
                                        color: const Color(0xff050a4e),
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              '₹ ${data['price'].toString()}/-',
                              style: GoogleFonts.nunito(
                                  fontSize: 18,
                                  color: const Color(0xff050a4e),
                                  fontWeight: FontWeight.w700),
                            ),
                            const SizedBox(
                              height: 14,
                            ),
                          ],
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image.asset(
                            'assets/icons/medical-test.png',
                            scale: 08,
                          ),
                          GestureDetector(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return TestAlertBox(
                                    currentDate: currentDate,
                                    name:data['name'],
                                    price: data['price'], 
                                  );
                                },
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 115, 16, 155),
                                borderRadius: BorderRadius.circular(6),
                                boxShadow: [
                                  BoxShadow(
                                    offset: const Offset(0, 10),
                                    blurRadius: 20,
                                    color:
                                        const Color.fromARGB(255, 175, 57, 186)
                                            .withOpacity(0.3),
                                  ),
                                ],
                              ),
                              child: const Center(
                                child: Text(
                                  'Schedule',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
          return const SizedBox(
            width: 100,
            height: 100,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        });
  }
}
