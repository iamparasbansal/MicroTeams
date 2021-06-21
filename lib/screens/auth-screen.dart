//------------------------------------------------------------------------
// This is the main Authentication Screen
// It handles the Signin Logic
//------------------------------------------------------------------------
import 'package:flutter/material.dart';
import 'package:microteams/screens/register-screen.dart';
import 'package:microteams/enums/auth-result-status.dart';
import 'package:microteams/screens/home-page.dart';
import 'package:microteams/authentication/auth-exception-handler.dart';
import 'package:microteams/authentication/firebase-auth-helper.dart';
import 'package:microteams/theme/app-colors.dart';
import 'package:microteams/utils/variables.dart';

class NavigateAuthScreen extends StatefulWidget {
  const NavigateAuthScreen({ Key? key }) : super(key: key);

  @override
  _NavigateAuthScreenState createState() => _NavigateAuthScreenState();
}

class _NavigateAuthScreenState extends State<NavigateAuthScreen> {

  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  bool isInProgress = false;

  _showAlertDialog(errorMsg) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'Login Failed',
            style: TextStyle(color: black),
          ),
          content: Text(errorMsg),
        );
      }
    );
  }

  //------------------------------------------------------------------------
  // This function hadles the click on Signin Button
  //------------------------------------------------------------------------
  _login() async {
    {
      setState(() {
        isInProgress = true;
      });
      final status =
        await FirebaseAuthHelper().login(
          email: emailcontroller.text, 
          password: passwordcontroller.text
        );
      setState(() {
        isInProgress = false;
      });
      if (status == AuthResultStatus.successful) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      } else {
        final errorMsg = AuthExceptionHandler.generateExceptionMessage(status);
        _showAlertDialog(errorMsg);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
  
    //------------------------------------------------------------------------
    // This is the container that appears on top of Login Screen
    // It includes brand name and the video png
    // Covers half of the background screen
    //------------------------------------------------------------------------
    var videoLogoImageContainer = Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height/2,
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
    
    //------------------------------------------------------------------------
    // General Text, i.e.,
    // Get Started with your work, school, or personal email
    //------------------------------------------------------------------------
    var generalText = SizedBox(
      width: MediaQuery.of(context).size.width/1.5,
      child: Container(
        child: Text(
          'Get started with your work, school, or personal email account',
          style: mystyle(20, black, FontWeight.w400),
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
      height: 42,
      child: TextField(
        style: mystyle(18, black, FontWeight.w400),
        keyboardType: TextInputType.emailAddress,
        controller: emailcontroller,
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
          hintText: "Enter your email",
          hintStyle: mystyle(18, grey, FontWeight.w400)
        ),
      ),
    );

    //------------------------------------------------------------------------
    // Password Text Field
    // Users will enter there account password here in order to login
    //------------------------------------------------------------------------
    var passwordTextField = Container(
      width: MediaQuery.of(context).size.width/1.4,
      height: 42,
      child: TextField(
        style: mystyle(18, black, FontWeight.w400),
        keyboardType: TextInputType.emailAddress,
        obscureText: true,
        controller: passwordcontroller,
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
          hintText: "Enter your password",
          hintStyle: mystyle(18, grey, FontWeight.w400)
        ),
      ),
    );

    //------------------------------------------------------------------------
    // Sign In Button
    //------------------------------------------------------------------------
    var signInButton = InkWell(
      onTap: (){
        _login();
      },
      child: Container(
        width: MediaQuery.of(context).size.width/1.4,
        height: 42,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [purpleSecondary, purpleSecondary]
          ),
          borderRadius: BorderRadius.circular(10)
        ),
        child: Center(
          child: Text(
            "Sign in", 
            style: mystyle(18, white, FontWeight.w400),
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
        height: 42,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: purpleSecondary,
            width: 2,
          ),
        ),
        child: Center(
          child: Text(
            "Join a meeting", 
            style: mystyle(18, purpleSecondary, FontWeight.w400),
          ),
        ),
      ),
    );

    //------------------------------------------------------------------------
    // Sign Up Button
    // It naviagates to registration-screen when clicked
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
        height: 42,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: purpleSecondary,
            width: 2,
          ),
        ),
        child: Center(
          child: Text(
            "Sign up for free", 
            style: mystyle(18, purpleSecondary, FontWeight.w400),
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
          mySizedBox(40),
          generalText,
          mySizedBox(20),
          emailTextField,
          mySizedBox(10),
          passwordTextField,
          mySizedBox(10),
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
          mySizedBox(10),
          signUpButton,
          mySizedBox(20),
        ],
      ),
    );

    return Scaffold(
      backgroundColor: greyLight,
      body: isInProgress? Center(
        child: CircularProgressIndicator(
          color: purpleSecondary,
        ),
      ) : Stack(
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
                    color: grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 5,
                    offset: const Offset(0,3),
                  ),
                ],
                color: white,
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