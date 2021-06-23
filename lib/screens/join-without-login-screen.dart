import 'package:flutter/material.dart';
import 'package:microteams/screens/video-conference/join-meeting.dart';
import 'package:microteams/theme/app-colors.dart';
import 'package:microteams/utils/variables.dart';

class JoinWithoutLogin extends StatefulWidget {
  const JoinWithoutLogin({ Key? key }) : super(key: key);

  @override
  _JoinWithoutLoginState createState() => _JoinWithoutLoginState();
}

class _JoinWithoutLoginState extends State<JoinWithoutLogin> {
  @override
  Widget build(BuildContext context) {


    var videoLogoImageContainer = Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height/2.5,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [purpleLight, purpleLight]
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width/1.4,
            child: Container(
              child: Text(
                'MicroTeams',
                style: mystyle(30, black, FontWeight.w600),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Image.asset(
            'images/logo.png', 
            height: 100,
          ),
          mySizedBox(50),
        ],
      ),
    );

    return Scaffold(
      backgroundColor: greyLight,
      body: Stack(
        children : [
          videoLogoImageContainer,
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 1.4,
              decoration: BoxDecoration(
                color: white,
              ),
              child: JoinMeeting(),
            ),
          ),
        ],
      ),
    );
  }
}