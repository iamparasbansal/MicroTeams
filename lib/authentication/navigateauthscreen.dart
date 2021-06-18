//------------------------------------------------------------------------
// This is the Auth Screen
// It covers the UI of Login/Signup Screen
//------------------------------------------------------------------------

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:microteams/authentication/registerscreen.dart';
import 'package:microteams/variables.dart';

class NavigateAuthScreen extends StatefulWidget {
  const NavigateAuthScreen({ Key? key }) : super(key: key);

  @override
  _NavigateAuthScreenState createState() => _NavigateAuthScreenState();
}

class _NavigateAuthScreenState extends State<NavigateAuthScreen> {

  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Color microTeamsLight = Color(0xff7B83EB);
    Color microTeamsSecondary = Color(0xff6264A7);

    //------------------------------------------------------------------------
    // This is the container that appears on top of Login Screen
    // It includes brand name and the video logo
    // Covers half of the background screen
    //------------------------------------------------------------------------
    var videoLogoImageContainer = Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height/2,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [microTeamsLight, microTeamsLight]
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
                style: mystyle(30, Colors.black, FontWeight.w600),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Image.asset(
            'images/logo.png', 
            height: 100,
          ),
          SizedBox(
            height: 50,
          ),
        ],
      ),
    );
    
    //------------------------------------------------------------------------
    // General Text, i.e.,
    // Get Started with your work, school, or personal email
    //------------------------------------------------------------------------
    var generalText = SizedBox(
      width: MediaQuery.of(context).size.width/1.5,
      child: Container(
        child: Text(
          'Get started with your work, school, or personal email account',
          style: mystyle(20, Colors.black, FontWeight.w400),
          textAlign: TextAlign.center,
        ),
      ),
    );

    //------------------------------------------------------------------------
    // Email Text Field
    // User will enter email here in order to login
    //------------------------------------------------------------------------
    var emailTextField = Container(
      width: MediaQuery.of(context).size.width/1.4,
      height: 46,
      child: TextField(
        style: mystyle(18, Colors.grey, FontWeight.w500),
        keyboardType: TextInputType.emailAddress,
        controller: emailcontroller,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(
            left: 10,
            bottom: 23,  // THIS MARGIN SHOULD BE HALF OF THE HEIGHT PROVIDED
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder:  OutlineInputBorder(
            borderSide: BorderSide(color: microTeamsSecondary, width: 2.0),
            borderRadius: BorderRadius.circular(10),
          ),
          hintText: "Enter your email",
          hintStyle: mystyle(18, Colors.grey, FontWeight.w400)
        ),
      ),
    );

    //------------------------------------------------------------------------
    // Password Text Field
    // Users will enter there account password here in order to login
    //------------------------------------------------------------------------
    var passwordTextField = Container(
      width: MediaQuery.of(context).size.width/1.4,
      height: 46,
      child: TextField(
        style: mystyle(17, Colors.grey, FontWeight.w500),
        keyboardType: TextInputType.emailAddress,
        obscureText: true,
        controller: passwordcontroller,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(
            left: 10,
            bottom: 23,  // THIS MARGIN SHOULD BE HALF OF THE HEIGHT PROVIDED
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder:  OutlineInputBorder(
            borderSide: BorderSide(color: microTeamsSecondary, width: 2.0),
            borderRadius: BorderRadius.circular(10),
          ),
          hintText: "Enter your password",
          hintStyle: mystyle(17, Colors.grey, FontWeight.w400)
        ),
      ),
    );

    //------------------------------------------------------------------------
    // Sign In Button
    //------------------------------------------------------------------------
    var signInButton = InkWell(
      onTap: (){
        try {
          FirebaseAuth.instance.signInWithEmailAndPassword(
            email: emailcontroller.text, 
            password: passwordcontroller.text
          );
          Navigator.pop(context);
        } catch (e) {
          print(e);
          var snackbar = SnackBar(
            content: Text(
              e.toString(),
              style: mystyle(15),
            )
          );
          ScaffoldMessenger.of(context).showSnackBar(snackbar);
        }
      },
      child: Container(
        width: MediaQuery.of(context).size.width/1.4,
        height: 46,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [microTeamsSecondary, microTeamsSecondary]
          ),
          borderRadius: BorderRadius.circular(10)
        ),
        child: Center(
          child: Text(
            "Sign in", 
            style: mystyle(20, Colors.white, FontWeight.w400),
          ),
        ),
      ),
    );

    //------------------------------------------------------------------------
    // Button for Joining Meeting directly as a Guest
    //------------------------------------------------------------------------
    var joinMeetingButton = InkWell(
      onTap: (){},
      child: Container(
        width: MediaQuery.of(context).size.width/1.4,
        height: 46,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: microTeamsSecondary,
            width: 2,
          ),
        ),
        child: Center(
          child: Text(
            "Join a meeting", 
            style: mystyle(20, microTeamsSecondary, FontWeight.w400),
          ),
        ),
      ),
    );

    //------------------------------------------------------------------------
    // Sign Up Button
    //------------------------------------------------------------------------
    var signUpButton = InkWell(
      onTap: ()=> Navigator.push(
        context, 
        MaterialPageRoute(
          builder: (context)=> RegisterScreen()
        )
      ),
      child: Container(
        width: MediaQuery.of(context).size.width/1.4,
        height: 46,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: microTeamsSecondary,
            width: 2,
          ),
        ),
        child: Center(
          child: Text(
            "Sign up for free", 
            style: mystyle(20, microTeamsSecondary, FontWeight.w400),
          ),
        ),
      ),
    );

    //------------------------------------------------------------------------
    // This Column Wraps up the General Text Field,
    // Email Text Field, Password Text Field,
    // And Sign In Button
    //------------------------------------------------------------------------
    var signInButtonColumn = Expanded(
      flex: 2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 40,
          ),
          generalText,
          SizedBox(
            height: 20,
          ),
          emailTextField,
          SizedBox(
            height: 10,
          ),
          passwordTextField,
          SizedBox(
            height: 10,
          ),
          signInButton,
        ],
      ),
    );

    //------------------------------------------------------------------------
    // This column wraps up the Join a meeting and Sign Up Buttons
    //------------------------------------------------------------------------
    var signUpButtonColumn = Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          joinMeetingButton,
          SizedBox(
            height: 10,
          ),
          signUpButton,
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );

    return Scaffold(
      backgroundColor: Colors.grey[250],
      body: Stack(
        children: [
          videoLogoImageContainer,
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 1.5,
              margin: EdgeInsets.only(left:30, right:30),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 5,
                    offset: const Offset(0,3),
                  ),
                ],
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20)
                ),
              ),
              child: Column(
                children: [
                  signInButtonColumn,
                  signUpButtonColumn,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}