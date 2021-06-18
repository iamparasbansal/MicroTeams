import 'package:flutter/material.dart';

class NavigateAuthScreen extends StatefulWidget {
  const NavigateAuthScreen({ Key? key }) : super(key: key);

  @override
  _NavigateAuthScreenState createState() => _NavigateAuthScreenState();
}

class _NavigateAuthScreenState extends State<NavigateAuthScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[250],
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height/2,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.teal, Colors.blue]
              )
            ),
            child: Center(
              child: Image.asset(
                'images/logo.png', 
                height: 100,
              ),
            ),
          )
        ],
      ),
    );
  }
}