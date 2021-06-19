import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:microteams/authentication/navigate-auth-screen.dart';
import 'package:microteams/variables.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({ Key? key }) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  String name = "";
  bool dataIsThere = false;

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  getUserData() async{
    DocumentSnapshot userDoc = await userCollection.doc(FirebaseAuth.instance.currentUser!.uid).get();
     setState((){
       name = (userDoc.data() as dynamic)['name'];
       dataIsThere = true;
     });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: dataIsThere == false ? Center(
        child: CircularProgressIndicator(),
      ) : Stack(
        children: [
          ClipPath(
            clipper: OvalBottomBorderClipper(),
            child: Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height/2.5,
              decoration: BoxDecoration(
                color: Color(0xff505AC9)
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              left: (MediaQuery.of(context).size.width / 2)-50,
              top: MediaQuery.of(context).size.height / 3.1,
            ),
            child:Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                shape: BoxShape.circle,
                image: DecorationImage(
                  image:  AssetImage('images/profile.png'),
                ),
              ),
            )
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 300,
                ),
                Text(
                  name,
                  style: mystyle(40, Colors.black),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  width: MediaQuery.of(context).size.width/2,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.black,
                  ),
                  child: Center(
                    child: Text(
                      "Edit Profile",
                      style: mystyle(17, Colors.white),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                InkWell(
                  onTap: (){
                    FirebaseAuth.instance.signOut();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => NavigateAuthScreen()),
                    );
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width/2,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.black,
                    ),
                    child: Center(
                      child: Text(
                        "Logout",
                        style: mystyle(17, Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}