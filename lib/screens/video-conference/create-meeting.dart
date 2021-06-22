import 'package:flutter/material.dart';
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

  createCodeFunction(){
    setState(() {
      code = Uuid().v1().substring(0, 6);
    });
  }

  @override
  Widget build(BuildContext context) {

    var createCodeContainer = Container(
      margin: EdgeInsets.only(
        top: 20
      ),
      child: Text(
        "Create a code and share",
        style: mystyle(20),
        textAlign: TextAlign.center,
      ),
    );

    var meetingCode = Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
          "Code: ",
          style: mystyle(30), 
        ),
        Text(
          code,
          style: mystyle(30, black, FontWeight.w600),
        ),
      ],
    );

    var createCode = InkWell(
      onTap: (){
        createCodeFunction();
      },
      child: Container(
        width: MediaQuery.of(context).size.width /2,
        height: 50,
        decoration: BoxDecoration(
          color: purpleSecondary,
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          createCodeContainer,
          mySizedBox(40),
          meetingCode,
          mySizedBox(25),
          createCode
        ],
      ),
    );
  }
}