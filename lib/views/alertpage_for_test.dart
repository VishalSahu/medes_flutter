import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TestAlertBox extends StatefulWidget {
  const TestAlertBox({
    Key? key,
    required this.currentDate,
    required this.name,
    required this.price,
  }) : super(key: key);

  final DateTime currentDate;
  final name;
  final price;
  @override
  State<TestAlertBox> createState() => _TestAlertBoxState();
}

DateTime currentDate = DateTime.now();

class _TestAlertBoxState extends State<TestAlertBox> {
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: widget.currentDate,
        firstDate: DateTime.now().subtract(
          const Duration(days: 0),
        ),
        lastDate: DateTime(2030));
    if (pickedDate != null && pickedDate != widget.currentDate) {
      setState(() {
        currentDate = pickedDate;
      });
    }
  }

  final _nameController = TextEditingController();
  final _myLocController = TextEditingController();
  final _contactNumberController = TextEditingController();
  Future createAppointment() async {
    User? user = FirebaseAuth.instance.currentUser;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .collection('appointments')
        .add({
      'name': _nameController.text.trim(),
      'address': _myLocController.text.trim(),
      'test-type': widget.name,
      'contact_info': _contactNumberController.text.trim(),
      'date': currentDate.toString().substring(0, 10),
    });
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content:
            Text("Schedule created successfully, check on schedule tab.")));
    Navigator.pop(context);
    dispose();
  }


  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Please this form'),
      content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: _nameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please fill your name';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.deepPurple),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    fillColor: Colors.grey[200],
                    filled: true,
                    hintText: 'Name',
                    border: InputBorder.none,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                TextFormField(
                  controller: _myLocController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please fill your address';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.deepPurple),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    fillColor: Colors.grey[200],
                    filled: true,
                    hintText: 'Address',
                    border: InputBorder.none,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                TextFormField(
                  controller: _contactNumberController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please fill contact information';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.deepPurple),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    fillColor: Colors.grey[200],
                    filled: true,
                    hintText: 'Mobile Number',
                    border: InputBorder.none,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Container(
                  height: 55,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.white),
                    color: Colors.grey[200],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        widget.currentDate.toString().substring(0, 10),
                        style: GoogleFonts.poppins(fontSize: 16),
                      ),
                      MaterialButton(
                        textColor: Colors.deepPurple,
                        elevation: 0,
                        onPressed: () => _selectDate(context),
                        child: Text(
                          'Select Date',
                          style: GoogleFonts.poppins(fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.redAccent,
                    borderRadius: BorderRadius.circular(6),
                    boxShadow: [
                      BoxShadow(
                        offset: const Offset(0, 10),
                        blurRadius: 20,
                        color: Colors.redAccent.withOpacity(0.3),
                      ),
                    ],
                  ),
                  child: const Center(
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: createAppointment,
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 115, 16, 155),
                    borderRadius: BorderRadius.circular(6),
                    boxShadow: [
                      BoxShadow(
                        offset: const Offset(0, 10),
                        blurRadius: 20,
                        color: const Color.fromARGB(255, 175, 57, 186)
                            .withOpacity(0.3),
                      ),
                    ],
                  ),
                  child: const Center(
                    child: Text(
                      'Confirm',
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
        ),
      ],
    );
  }
}
