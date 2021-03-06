import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:microteams/enums/auth-result-status.dart';
import 'package:microteams/authentication/auth-exception-handler.dart';
import 'package:microteams/authentication/firebase-auth-helper.dart';
import 'package:microteams/screens/auth-screen.dart';
import 'package:microteams/theme/app-colors.dart';
import 'package:microteams/utils/variables.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController namecontroller = TextEditingController();
  bool isInProgress = false;
  final auth = FirebaseAuth.instance;
  User? user;

  _showAlertDialogSignupFail(errorTitle, errorMsg) {
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

  _showAlertDialogVerifyEmail(errorTitle, errorMsg) {
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

  _verifyEmailAddress() async {
    user = auth.currentUser;
    user!.sendEmailVerification();
    _showAlertDialogVerifyEmail(
      "Verify your Email",
      "A verify link has been sent to ${user!.email} please verify and then login."
    );
  }

  //------------------------------------------------------------------------
  // This function hadles the click on Signup Button
  //------------------------------------------------------------------------
  _createAccount() async {
    if (namecontroller.text == '') {
      _showAlertDialogSignupFail(
        "Signup Failed",
        "Name field is empty, please fill it."
      );
    } else {
      setState(() {
        isInProgress = true;
      });
      final status = await FirebaseAuthHelper().createAccount(
        email: emailcontroller.text,
        password: passwordcontroller.text,
        name: namecontroller.text
      );
      setState(() {
        isInProgress = false;
      });
      if (status == AuthResultStatus.successful) {
        _verifyEmailAddress();
      } else {
        final errorMsg = AuthExceptionHandler.generateExceptionMessage(status);
        _showAlertDialogSignupFail("Signup Failed", errorMsg);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    //------------------------------------------------------------------------
    // This is the container that appears on top of Signup Screen
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
    // Name Text Field to get user input of name for new account
    //------------------------------------------------------------------------
    var nameTextField = Container(
      width: MediaQuery.of(context).size.width / 1.4,
      height: 42,
      child: TextField(
        style: mystyle(18, black, FontWeight.w400),
        keyboardType: TextInputType.emailAddress,
        controller: namecontroller,
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
            hintText: "Name",
            hintStyle: mystyle(18, grey, FontWeight.w400)),
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
    // Password Text Field
    // Users will enter there new account password here in order to signup
    //------------------------------------------------------------------------
    var passwordTextField = Container(
      width: MediaQuery.of(context).size.width / 1.4,
      height: 42,
      child: TextField(
        style: mystyle(18, black, FontWeight.w400),
        keyboardType: TextInputType.emailAddress,
        obscureText: true,
        controller: passwordcontroller,
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
            hintText: "Password",
            hintStyle: mystyle(18, grey, FontWeight.w400)),
      ),
    );

    //------------------------------------------------------------------------
    // Sign Up Button
    //------------------------------------------------------------------------
    var signUpButton = InkWell(
      onTap: () {
        _createAccount();
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
            "Sign up",
            style: mystyle(18, white, FontWeight.w400),
          ),
        ),
      ),
    );

    //------------------------------------------------------------------------
    // Column to wrap text fields and signup button
    //------------------------------------------------------------------------
    var signUpColumn = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        nameTextField,
        mySizedBox(10),
        emailTextField,
        mySizedBox(10),
        passwordTextField,
        mySizedBox(20),
        signUpButton,
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
                    child: signUpColumn,
                  ),
                ),
              ],
            ),
    );
  }
}
