import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:microteams/screens/home-page.dart';
import 'package:microteams/screens/intro-screens.dart';
import 'package:flutter/services.dart';

void main() async {
  //---------------------------------------------------------------
  // Initialize the Firebase and env variables
  // Also set app preffered orientation to be potrait only
  //---------------------------------------------------------------
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterConfig.loadEnvVariables();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  //-------------------------------------------------------------
  // This widget is the root of application.
  //-------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: NavigationPage(),
    );
  }
}

class NavigationPage extends StatefulWidget {
  const NavigationPage({ Key? key }) : super(key: key);

  @override
  _NavigationPageState createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  
  bool isSigned = false;

  @override
  void initState() {
    super.initState();
    //---------------------------------------------------------------
    // This checks if the user is Signed in or not on launch
    //---------------------------------------------------------------
    FirebaseAuth.instance.authStateChanges().listen((user){
      if(user!=null){
        setState(() {
          isSigned = true;
        });
      }else{
        setState(() {
          isSigned = false;
        });
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isSigned == false ? IntroAuthScreen() : HomePage(),
    );
  }
}

