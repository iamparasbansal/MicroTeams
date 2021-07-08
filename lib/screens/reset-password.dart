import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:microteams/screens/auth-screen.dart';
import 'package:microteams/theme/app-colors.dart';
import 'package:microteams/utils/variables.dart';

class ResetScreen extends StatefulWidget {
  const ResetScreen({Key? key}) : super(key: key);

  @override
  _ResetScreenState createState() => _ResetScreenState();
}

class _ResetScreenState extends State<ResetScreen> {
  TextEditingController emailcontroller = TextEditingController();
  bool isInProgress = false;
  final auth = FirebaseAuth.instance;

  _showAlertDialogChangePasswordFail(errorTitle, errorMsg) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            errorTitle,
            style: TextStyle(color: black),
          ),
          content: Text(errorMsg),
        );
      }
    );
  }

  _showAlertDialogChangePassword(errorTitle, errorMsg) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            errorTitle,
            style: TextStyle(color: black),
          ),
          content: Text(errorMsg),
          actions: [
            TextButton(
              child: const Text('Okay'),
              onPressed: () {
                Navigator.push(
                  context, MaterialPageRoute(
                    builder: (context) => NavigateAuthScreen()
                  )
                );
              },
            ),
          ],
        );
      }
    );
  }

  //------------------------------------------------------------------------
  // This function hadles the click on Change Password Button
  //------------------------------------------------------------------------
  _changePassword() async {
    if (emailcontroller.text == '') {
      _showAlertDialogChangePasswordFail(
        "Change Password Failed",
        "Email field is empty, please fill it."
      );
    } else {
      setState(() {
        isInProgress = true;
      });
      auth.sendPasswordResetEmail(email: emailcontroller.text);
      setState(() {
        isInProgress = false;
      });
      _showAlertDialogChangePassword(
        "Link sent", 
        "Please click the link sent on your email and continue to change the password."
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    //------------------------------------------------------------------------
    // This is the container that appears on top of changePassword Screen
    // It includes brand name and the video logo
    // Covers half of the background screen
    //------------------------------------------------------------------------
    var videoLogoImageContainer = Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 2,
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [blueSecondary, blueSecondary]),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width / 1.4,
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
        ],
      ),
    );

    //------------------------------------------------------------------------
    // General Text, i.e.,
    // Get Started with your work, school, or personal email
    //------------------------------------------------------------------------
    var generalText = SizedBox(
      width: MediaQuery.of(context).size.width / 1.5,
      child: Container(
        child: Text(
          'Please enter your Email',
          style: mystyle(20, black, FontWeight.w400),
          textAlign: TextAlign.center,
        ),
      ),
    );


    //------------------------------------------------------------------------
    // Email Text Field to get user input of email for new account
    //------------------------------------------------------------------------
    var emailTextField = Container(
      width: MediaQuery.of(context).size.width / 1.4,
      height: 42,
      child: TextField(
        style: mystyle(18, black, FontWeight.w400),
        keyboardType: TextInputType.emailAddress,
        controller: emailcontroller,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.only(
              left: 10,
              bottom: 21, // THIS MARGIN SHOULD BE HALF OF THE HEIGHT PROVIDED
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: blueSecondary, width: 2.0),
              borderRadius: BorderRadius.circular(10),
            ),
            hintText: "Email address",
            hintStyle: mystyle(18, grey, FontWeight.w400)),
      ),
    );

    //------------------------------------------------------------------------
    // Change Password Button
    //------------------------------------------------------------------------
    var changePasswordButton = InkWell(
      onTap: () {
        _changePassword();
      },
      child: Container(
        width: MediaQuery.of(context).size.width / 1.4,
        height: 42,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [blueSecondary, blueSecondary]),
            borderRadius: BorderRadius.circular(10)),
        child: Center(
          child: Text(
            "Change password",
            style: mystyle(18, white, FontWeight.w400),
          ),
        ),
      ),
    );

    //------------------------------------------------------------------------
    // Column to wrap text fields and Change Password button
    //------------------------------------------------------------------------
    var changePasswordColumn = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        generalText,
        mySizedBox(20),
        emailTextField,
        mySizedBox(20),
        changePasswordButton,
      ],
    );

    return Scaffold(
      backgroundColor: greyLight,
      body: isInProgress
          ? Center(
              child: CircularProgressIndicator(color: blueSecondary),
            )
          : Stack(
              children: [
                videoLogoImageContainer,
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 1.7,
                    decoration: BoxDecoration(
                      color: white,
                    ),
                    child: changePasswordColumn,
                  ),
                ),
              ],
            ),
    );
  }
}
