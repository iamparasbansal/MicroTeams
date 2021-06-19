import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:microteams/authentication/navigate-auth-screen.dart';
import 'package:microteams/variables.dart';

class IntroAuthScreen extends StatefulWidget {
  const IntroAuthScreen({ Key? key }) : super(key: key);
  @override
  _IntroAuthScreenState createState() => _IntroAuthScreenState();
}

class _IntroAuthScreenState extends State<IntroAuthScreen> {
  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      pages: [
        PageViewModel(
          title: "Welcome",
          body: "Welcome to MicroTeams, the best video conference app",
          image: Center(
            child: Image.asset('images/welcome.png', height: 200 ),
          ),
          decoration: PageDecoration(
            bodyTextStyle: mystyle(20,Colors.black),
            titleTextStyle: mystyle(25,Colors.black),
          )
        ),
        PageViewModel(
          title: "Join or Start meetings",
          body: "Easy to use interface, join or start meetings in a fast time",
          image: Center(
            child: Image.asset('images/conference.png', height: 250 ),
          ),
          decoration: PageDecoration(
            bodyTextStyle: mystyle(20,Colors.black),
            titleTextStyle: mystyle(25,Colors.black)
          )
        ),
        PageViewModel(
          title: "Security",
          body: "Your security is important for us. Our servers are secure and reliable",
          image: Center(
            child: Image.asset('images/secure.png', height: 280 ),
          ),
          decoration: PageDecoration(
            bodyTextStyle: mystyle(20,Colors.black),
            titleTextStyle: mystyle(25,Colors.black)
          )
        )
      ],
      color: Colors.blue,
      onDone: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>NavigateAuthScreen()));
      },
      showSkipButton: true,
      skip: Text(
        "Skip", 
        style: mystyle(20,Colors.black),
      ),
      next: const Icon(
        Icons.arrow_forward, 
        size: 30, 
        color: Colors.black,
      ),
      done: Text(
        "Done", 
        style: mystyle(20,Colors.black),
      ),
      dotsDecorator: DotsDecorator(
        size: const Size.square(10.0),
        activeSize: const Size(20.0, 10.0),
        activeColor: Color(0xff6264A7),
        color: Colors.black26,
        spacing: const EdgeInsets.symmetric(horizontal: 5.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0)
        )
      )
    );
  }
}