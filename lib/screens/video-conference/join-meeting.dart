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

  TextEditingController nameController = TextEditingController();
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

     print("Paras Bansal");
     print(roomController.text);

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
      ..userDisplayName = nameController.text == '' ? name : nameController.text
      ..audioMuted = isAudioMuted
      ..videoMuted = isVideoMuted
      ..featureFlags.addAll(featureFlags);
      print("Paras Bansal");
      print(roomController.text);
      await JitsiMeet.joinMeeting(options);
    } catch(e) {
      print("Error: $e");
      print("Paras Bansal");
      print(roomController.text);
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
        height: 64,
        decoration: BoxDecoration(
          color: purpleSecondary,
        ),
        child: Center(
          child: Text(
            "Join Meeting",
            style: mystyle(20, white),
          ),
        ),
      )
    );


    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 16
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              mySizedBox(24),
              Text(
                "Room Code",
                style: mystyle(20),
              ),
              mySizedBox(20),
              PinCodeTextField(
                controller: roomController,
                appContext: context, 
                length: 6,
                autoDisposeControllers: false,
                animationType: AnimationType.fade,
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.underline
                ), 
                animationDuration: Duration(milliseconds: 300),
                onChanged: (value){},
              ),
              mySizedBox(10),
              TextField(
                controller: nameController,
                style: mystyle(20),
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Name",
                  labelStyle: mystyle(15)
                ),
              ),
              mySizedBox(16),
              CheckboxListTile(
                value: isVideoMuted, 
                onChanged: (value){
                  setState(() {
                    isVideoMuted = value;
                  });
                },
                title: Text(
                  "Video Muted", 
                  style: mystyle(18, black)
                ),
              ),
              mySizedBox(16),
              CheckboxListTile(
                value: isAudioMuted, 
                onChanged: (value){
                  setState(() {
                    isAudioMuted = value;
                  });
                },
                title: Text(
                  "Audio Muted", 
                  style: mystyle(18, black)
                ),
              ),
              mySizedBox(20),
              Text(
                "You can change theses settings later",
                style: mystyle(15),
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
    );
  }
}