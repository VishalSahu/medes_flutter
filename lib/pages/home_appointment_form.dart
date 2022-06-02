import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeAppointment extends StatefulWidget {
  const HomeAppointment({Key? key}) : super(key: key);

  @override
  State<HomeAppointment> createState() => _HomeAppointmentState();
}

class _HomeAppointmentState extends State<HomeAppointment> {
  final _nameController = TextEditingController();
  final _myLocController = TextEditingController();
  final _contactNumberController = TextEditingController();
  DateTime currentDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: currentDate,
        firstDate: DateTime.now().subtract(
          const Duration(days: 0),
        ),
        lastDate: DateTime(2030));
    if (pickedDate != null && pickedDate != currentDate) {
      setState(() {
        currentDate = pickedDate;
      });
    }
  }

  String dropdownValue = 'Test';

  Future createAppointment() async {
    User? user = FirebaseAuth.instance.currentUser;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .collection('appointments')
        .add({
      'name': _nameController.text.trim(),
      'address': _myLocController.text.trim(),
      'test-type': dropdownValue.toString().trim(),
      'contact_info': _contactNumberController.text.trim(),
      'date': currentDate.toString().substring(0, 10),
    });
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Form submitted successfully.")));
    Navigator.pop(context);
    dispose();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _myLocController.dispose();
    _contactNumberController.dispose();
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Scaffold(
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
                      'Home Appointment',
                      style: GoogleFonts.poppins(
                          fontSize: 42, fontWeight: FontWeight.w200),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      'Fill below with person\'s detail!',
                      style: GoogleFonts.poppins(
                          fontSize: 20, fontWeight: FontWeight.w300),
                    ),

                    const SizedBox(height: 50),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Container(
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
                              currentDate.toString().substring(0, 10),
                              style: GoogleFonts.poppins(fontSize: 16),
                            ),
                            const SizedBox(
                              width: 100,
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
                    ),
                    const SizedBox(
                      height: 10,
                    ),
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
                            return 'Please fill address';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.streetAddress,
                        controller: _myLocController,
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
                          if (value == null ||
                              value.isEmpty ||
                              value.length != 10) {
                            return 'Please fill proper contact number';
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

                    //password field
                    Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 25,
                        ),
                        child: Container(
                          height: 55,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.white),
                            color: Colors.grey[200],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Select the medical test'),
                                DropdownButton<String>(
                                  value: dropdownValue,
                                  icon: const Icon(Icons.expand_more),
                                  elevation: 16,
                                  style:
                                      const TextStyle(color: Colors.deepPurple),
                                  underline: Container(
                                    height: 0,
                                  ),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      dropdownValue = newValue!;
                                    });
                                  },
                                  items: <String>[
                                    'Test',
                                    'Cholesterol Test',
                                    'CT Scan',
                                    'DNA Test'
                                  ].map<DropdownMenuItem<String>>(
                                      (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                ),
                              ],
                            ),
                          ),
                        )),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 40, vertical: 16),
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 192, 73, 73),
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  offset: const Offset(0, 10),
                                  blurRadius: 50,
                                  color: const Color.fromARGB(255, 192, 73, 73)
                                      .withOpacity(0.23),
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
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              createAppointment();
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 40, vertical: 16),
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
                                'Submit',
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
                  ]),
            ),
          ),
        ),
      ),
    ));
  }
}
