//------------------------------------------------------------------------
// This is the Home page
// It has a Bottom Navigation Bar
// So that User can switch between Video Conference and Profile Page
//------------------------------------------------------------------------

import 'package:flutter/material.dart';
import 'package:microteams/screens/profile-screen.dart';
import 'package:microteams/screens/video-conference-screen.dart';
import 'package:microteams/theme/app-colors.dart';
import 'package:microteams/utils/variables.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int page = 0;
  List pageOptions = [VideoConferenceScreen(), ProfileScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: greyLight,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: white,
        selectedItemColor: blueSecondary,
        selectedLabelStyle: mystyle(17, blueSecondary),
        unselectedItemColor: black,
        unselectedLabelStyle: mystyle(17, black),
        currentIndex: page,
        onTap: (index) {
          setState(() {
            page = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            label: "Video Call",
            icon: Icon(Icons.video_call, size: 32),
          ),
          BottomNavigationBarItem(
            label: "Profile",
            icon: Icon(Icons.person, size: 32),
          ),
        ],
      ),
      body: pageOptions[page],
    );
  }
}
