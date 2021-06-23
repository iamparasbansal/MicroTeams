import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jitsi_meet/jitsi_meet.dart';
import 'package:microteams/theme/app-colors.dart';
import 'package:microteams/utils/variables.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class JoinMeeting extends StatefulWidget {
  const JoinMeeting({ Key? key }) : super(key: key);

  @override
  _JoinMeetingState createState() => _JoinMeetingState();
}

class _JoinMeetingState extends State<JoinMeeting> {

  TextEditingController roomController = TextEditingController();
  bool? isVideoMuted = true;
  bool? isAudioMuted = true;
  String name = '';

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  //------------------------------------------------------------------------
  // Function to get User Data from Firestore Database
  //------------------------------------------------------------------------
  getUserData() async {
    DocumentSnapshot userDoc = await userCollection.doc(FirebaseAuth.instance.currentUser!.uid).get();
     setState((){
       name = (userDoc.data() as dynamic)['name'];
     });
  }


  joinMeetingFunction() async{

    try{
      Map<FeatureFlagEnum, bool> featureFlags = {
        FeatureFlagEnum.WELCOME_PAGE_ENABLED : false
      };

      if (Platform.isAndroid){
        featureFlags[FeatureFlagEnum.CALL_INTEGRATION_ENABLED] = false;
      } else if (Platform.isIOS) {
        featureFlags[FeatureFlagEnum.PIP_ENABLED] = false;
      }

      var options = JitsiMeetingOptions(room: roomController.text)
      ..userDisplayName = name 
      ..audioMuted = isAudioMuted
      ..videoMuted = isVideoMuted
      ..featureFlags.addAll(featureFlags);
    
      await JitsiMeet.joinMeeting(options);
    } catch(e) {
      print("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {

    var joinMeetingButton = InkWell(
      onTap: (){
        joinMeetingFunction();
      },
      child: Container(
        width: double.maxFinite,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: purpleSecondary,
        ),
        child: Center(
          child: Text(
            "Join Meeting",
            style: mystyle(20, white, FontWeight.w500),
          ),
        ),
      )
    );


    return Scaffold(
      backgroundColor: greyLight,
      body: Center(
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 25
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                mySizedBox(24),
                Text(
                  "Enter the code provided by the meeting organizer",
                  style: mystyle(18, black, FontWeight.w400),
                  textAlign: TextAlign.center,
                ),
                mySizedBox(30),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20
                  ),
                  child: PinCodeTextField(
                    controller: roomController,
                    appContext: context, 
                    length: 6,
                    cursorColor: black,
                    autoDisposeControllers: false,
                    textStyle: mystyle(25, black, FontWeight.w400),
                    animationType: AnimationType.fade,
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.underline,
                      inactiveColor: purpleSecondary,
                      activeColor: purpleSecondary,
                      selectedColor: black,
                      fieldHeight: 35,
                    ), 
                    animationDuration: Duration(milliseconds: 200),
                    onChanged: (value){},
                  ),
                ),
                mySizedBox(20),
                CheckboxListTile(
                  value: isVideoMuted,
                  activeColor: purpleSecondary, 
                  dense: true,
                  onChanged: (value){
                    setState(() {
                      isVideoMuted = value;
                    });
                  },
                  title: Text(
                    "Video Muted", 
                    style: mystyle(18, black, FontWeight.w500)
                  ),
                ),
                CheckboxListTile(
                  value: isAudioMuted,
                  activeColor: purpleSecondary, 
                  dense: true, 
                  onChanged: (value){
                    setState(() {
                      isAudioMuted = value;
                    });
                  },
                  title: Text(
                    "Audio Muted", 
                    style: mystyle(18, black, FontWeight.w500)
                  ),
                ),
                Divider(
                  height: 48,
                  thickness: 2.0,
                ),
                Text(
                  "You can change theses settings later",
                  style: mystyle(16, black, FontWeight.w500),
                  textAlign: TextAlign.center,
                ),
                Divider(
                  height: 48,
                  thickness: 2.0,
                ),
                joinMeetingButton
              ],
            ),
          ),
        ),
      ),
    );
  }
}