import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:medes/pages/appointments_list.dart';
import 'package:medes/pages/home_page.dart';
import 'package:medes/pages/news_article_page.dart';
import 'package:medes/pages/profile_page.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;
  final pages = const [
    HomePage(),
    NewsArticlePage(),
    AppointmentList(),
    ProfilePage(),
  ];
  final user = FirebaseAuth.instance.currentUser!;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.purple[200]!.withOpacity(0.2),
              blurRadius: 25.0,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: GNav(
            gap: 10,
            curve: Curves.fastOutSlowIn,

            color: Colors.black, // unselected icon color
            activeColor: Colors.deepPurple,
            iconSize: 24,
            tabBackgroundColor: Colors.purple.withOpacity(0.1),
            tabActiveBorder: Border.all(color: Colors.grey[100]!, width: 1),

            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            selectedIndex: _selectedIndex,
            onTabChange: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            tabs: const [
              GButton(
                icon: Icons.home,
                text: 'Home',
              ),
              GButton(
                icon: Icons.article,
                text: 'Articles',
              ),
              GButton(
                icon: Icons.event_note,
                text: 'Appointments',
              ),
              GButton(
                icon: Icons.person,
                text: 'Profile',
              )
            ],
          ),
        ),
      ),
      body: pages[_selectedIndex],
    );
  }
}
