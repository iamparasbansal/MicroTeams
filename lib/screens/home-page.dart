import 'package:flutter/material.dart';
import 'package:microteams/screens/profile-screen.dart';
import 'package:microteams/screens/video-conference-screen.dart';
import 'package:microteams/variables.dart';

class HomePage extends StatefulWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int page = 0;
  List pageOptions = [ VideoConferenceScreen(), ProfileScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: Color(0xff6264A7),
        selectedLabelStyle: mystyle(17, Color(0xff6264A7)),
        unselectedItemColor: Colors.black,
        unselectedLabelStyle: mystyle(17, Colors.black),
        currentIndex: page,
        onTap: (index){
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