import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jitsi_meet/jitsi_meet.dart';
import 'package:microteams/theme/app-colors.dart';
import 'package:microteams/utils/variables.dart';
import 'package:uuid/uuid.dart';

class CreateMeeting extends StatefulWidget {
  const CreateMeeting({ Key? key }) : super(key: key);

  @override
  _CreateMeetingState createState() => _CreateMeetingState();
}

class _CreateMeetingState extends State<CreateMeeting> {

  String code = '';
  String name = '';
  String email = '';
  TextEditingController meetingTitleController = TextEditingController();
  bool? isVideoMuted = true;
  bool? isAudioMuted = true;

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
       email = (userDoc.data() as dynamic)['email'];
     });
  }

  createMeetingCodeFunction(){
    setState(() {
      code = Uuid().v1().substring(0, 6);
    });
  }

  createMeetingFunction() async{
    createMeetingCodeFunction();
    try{
      Map<FeatureFlagEnum, bool> featureFlags = {
        FeatureFlagEnum.WELCOME_PAGE_ENABLED : false
      };

      if (Platform.isAndroid){
        featureFlags[FeatureFlagEnum.CALL_INTEGRATION_ENABLED] = false;
      } else if (Platform.isIOS) {
        featureFlags[FeatureFlagEnum.PIP_ENABLED] = false;
      }

      var options = JitsiMeetingOptions(room: code)
      ..subject = meetingTitleController.text
      ..serverURL = "https://microteams.tech"
      ..userDisplayName = name
      ..userEmail = email
      ..audioMuted = isAudioMuted
      ..videoMuted = isVideoMuted
      ..featureFlags.addAll(featureFlags);
    
      await JitsiMeet.joinMeeting(options);
    } catch(e) {
      print("Error: $e");
    }
  }

  openGetMeetingLinkDialog() async {
    createMeetingCodeFunction();
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            "Here's your joining code"
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children:[
              Text(
                "Send this to people you want to meet with. Be sure you save it so you can use it later, too."
              ),
              mySizedBox(25),
              Text(
                "Code: $code",
                style: mystyle(18, black, FontWeight.w500),
              ),
              mySizedBox(20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Close",
                      style: mystyle(18, purpleSecondary, FontWeight.w500)
                    ),
                  )
                ],
              ),
            ]
          ),
        );
      }
    );
  }


  @override
  Widget build(BuildContext context) {

    var createMeetingText = Container(
      child: Text(
        "Start an instant meeting",
        style: mystyle(20, black, FontWeight.w600),
        textAlign: TextAlign.center,
      )
    );

    var meetingTitleTextField = Container(
      width: MediaQuery.of(context).size.width/1.5,
      height: 50,
      child: TextField(
        style: mystyle(18, black, FontWeight.w400),
        keyboardType: TextInputType.emailAddress,
        controller: meetingTitleController,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(
            left: 10,
            bottom: 21,  // THIS MARGIN SHOULD BE HALF OF THE HEIGHT PROVIDED
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder:  OutlineInputBorder(
            borderSide: BorderSide(color: purpleSecondary, width: 2.0),
            borderRadius: BorderRadius.circular(10),
          ),
          hintText: "Meeting title (optional)",
          hintStyle: mystyle(18, grey, FontWeight.w400)
        ),
      ),
    );

    var createMeetingButton = InkWell(
      onTap: (){
        createMeetingFunction();
      },
      child: Container(
        width: MediaQuery.of(context).size.width /1.5,
        height: 50,
        decoration: BoxDecoration(
          color: purpleSecondary,
          borderRadius: BorderRadius.circular(10)
        ),
        child: Center(
          child: Text(
            "Start Meeting",
            style: mystyle(20, white),
          ),
        ),
      )
    );

    var getMeetingLinkText = Container(
      child: Text(
        "Get joining code to share",
        style: mystyle(20, black, FontWeight.w600),
        textAlign: TextAlign.center,
      )
    );

    var getMeetingLinkButton = InkWell(
      onTap: (){
        openGetMeetingLinkDialog();
      },
      child: Container(
        width: MediaQuery.of(context).size.width /1.5,
        height: 50,
        decoration: BoxDecoration(
          color: purpleSecondary,
          borderRadius: BorderRadius.circular(10)
        ),
        child: Center(
          child: Text(
            "Create Code",
            style: mystyle(20, white),
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                mySizedBox(20),
                createMeetingText,
                mySizedBox(20),
                meetingTitleTextField,
                mySizedBox(10),
                createMeetingButton,
                mySizedBox(30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "OR",
                      style: mystyle(20, black)
                    )
                  ],
                ),
                mySizedBox(30),
                getMeetingLinkText,
                mySizedBox(10),
                getMeetingLinkButton,
              ],
            ),
          ),
        ),
      ),
    );
  }
}