//------------------------------------------------------------------------
// Intro Screens
// 3 Welcome Page when user first opens the app
// Each Page is a PageViewModel
//------------------------------------------------------------------------

import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:microteams/screens/auth-screen.dart';
import 'package:microteams/theme/app-colors.dart';
import 'package:microteams/utils/variables.dart';

class IntroAuthScreen extends StatefulWidget {
  const IntroAuthScreen({Key? key}) : super(key: key);
  @override
  _IntroAuthScreenState createState() => _IntroAuthScreenState();
}

class _IntroAuthScreenState extends State<IntroAuthScreen> {
  //------------------------------------------------------------------------
  // Welcome Page 1
  //------------------------------------------------------------------------
  var welcomePage1 = PageViewModel(
      title: "Welcome",
      body: "Welcome to MicroTeams, the best video conference app",
      image: Center(
        child: Image.asset('images/welcome.png', height: 250),
      ),
      decoration: PageDecoration(
        bodyTextStyle: mystyle(20, black),
        titleTextStyle: mystyle(25, black),
      ));

  //------------------------------------------------------------------------
  // Welcome Page 2
  //------------------------------------------------------------------------
  var welcomePage2 = PageViewModel(
      title: "Join or Start meetings",
      body: "Easy to use interface, join or start meetings in a fast time",
      image: Center(
        child: Image.asset('images/conference.png', height: 240),
      ),
      decoration: PageDecoration(
          bodyTextStyle: mystyle(20, black),
          titleTextStyle: mystyle(25, black)));

  //------------------------------------------------------------------------
  // Welcome Page 3
  //------------------------------------------------------------------------
  var welcomePage3 = PageViewModel(
      title: "Security",
      body:
          "Your security is important for us. Our servers are secure and reliable",
      image: Center(
        child: Image.asset('images/secure.png', height: 240),
      ),
      decoration: PageDecoration(
          bodyTextStyle: mystyle(20, black),
          titleTextStyle: mystyle(25, black)));

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
        pages: [welcomePage1, welcomePage2, welcomePage3],
        onDone: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => NavigateAuthScreen()));
        },
        showSkipButton: true,
        skip: Text(
          "Skip",
          style: mystyle(20, black),
        ),
        next: const Icon(
          Icons.arrow_forward,
          size: 30,
          color: black,
        ),
        done: Text(
          "Done",
          style: mystyle(20, black),
        ),
        dotsDecorator: DotsDecorator(
            size: const Size.square(10.0),
            activeSize: const Size(20.0, 10.0),
            activeColor: blueSecondary,
            color: black,
            spacing: const EdgeInsets.symmetric(horizontal: 5.0),
            activeShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0))));
  }
}
