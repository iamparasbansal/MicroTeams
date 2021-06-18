import 'package:flutter/material.dart';
import 'package:microteams/variables.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({ Key? key }) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    Color microTeamsLight = Color(0xff7B83EB);
    Color microTeamsSecondary = Color(0xff6264A7);

    //------------------------------------------------------------------------
    // This is the container that appears on top of Signup Screen
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
        ],
      ),
    );

    var usernameTextField = Container(
      width: MediaQuery.of(context).size.width/1.4,
      height: 46,
      child: TextField(
        style: mystyle(18, Colors.grey, FontWeight.w500),
        keyboardType: TextInputType.emailAddress,
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
          hintText: "Username",
          hintStyle: mystyle(18, Colors.grey, FontWeight.w400)
        ),
      ),
    );

    var emailTextField = Container(
      width: MediaQuery.of(context).size.width/1.4,
      height: 46,
      child: TextField(
        style: mystyle(18, Colors.grey, FontWeight.w500),
        keyboardType: TextInputType.emailAddress,
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
          hintText: "Email address",
          hintStyle: mystyle(18, Colors.grey, FontWeight.w400)
        ),
      ),
    );

    var passwordTextField = Container(
      width: MediaQuery.of(context).size.width/1.4,
      height: 46,
      child: TextField(
        style: mystyle(18, Colors.grey, FontWeight.w500),
        keyboardType: TextInputType.emailAddress,
        obscureText: true,
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
          hintText: "Password",
          hintStyle: mystyle(18, Colors.grey, FontWeight.w400)
        ),
      ),
    );

    var signUpButton = InkWell(
      onTap: (){},
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
            "Sign up", 
            style: mystyle(20, Colors.white, FontWeight.w400),
          ),
        ),
      ),
    );
    
    return Scaffold(
      backgroundColor: Colors.grey[250],
      body: Stack(
        children : [
          videoLogoImageContainer,
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 1.7,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20)
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  usernameTextField,
                  SizedBox(
                    height: 10,
                  ),
                  emailTextField,
                  SizedBox(
                    height: 10,
                  ),
                  passwordTextField,
                  SizedBox(
                    height: 20,
                  ),
                  signUpButton,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}