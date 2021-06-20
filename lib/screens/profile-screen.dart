//------------------------------------------------------------------------
// Profile Screen of User
//------------------------------------------------------------------------

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:microteams/screens/navigate-auth-screen.dart';
import 'package:microteams/theme/app-colors.dart';
import 'package:microteams/utils/variables.dart';

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

  //------------------------------------------------------------------------
  // Function to get User Data from Firestore Database
  //------------------------------------------------------------------------
  getUserData() async{
    DocumentSnapshot userDoc = await userCollection.doc(FirebaseAuth.instance.currentUser!.uid).get();
     setState((){
       name = (userDoc.data() as dynamic)['name'];
       dataIsThere = true;
     });
  }
  
  @override
  Widget build(BuildContext context) {

    //------------------------------------------------------------------------
    // Circular Purple Clip at Top of Profile Page
    //------------------------------------------------------------------------
    var clipPath = ClipPath(
      clipper: OvalBottomBorderClipper(),
      child: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height/2.5,
        decoration: BoxDecoration(
          color: purplePrimary
        ),
      ),
    );

    //------------------------------------------------------------------------
    // User Profile Pic Container
    //------------------------------------------------------------------------
    var circleAvatar = Container(
      margin: EdgeInsets.only(
        left: (MediaQuery.of(context).size.width / 2)-50,
        top: MediaQuery.of(context).size.height / 3.1,
      ),
      child:Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          color: greyLight,
          shape: BoxShape.circle,
          image: DecorationImage(
            image:  AssetImage('images/profile.png'),
          ),
        ),
      )
    );

    //------------------------------------------------------------------------
    // Button to provide Edit Profile Functionality
    //------------------------------------------------------------------------
    var editProfileButton = Container(
      width: MediaQuery.of(context).size.width/2,
      height: 40,
      decoration: BoxDecoration(
        color: black,
      ),
      child: Center(
        child: Text(
          "Edit Profile",
          style: mystyle(17, white),
        ),
      ),
    );

    //------------------------------------------------------------------------
    // Logout Button
    //------------------------------------------------------------------------
    var logoutButton = InkWell(
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
          color: black,
        ),
        child: Center(
          child: Text(
            "Logout",
            style: mystyle(17, white),
          ),
        ),
      ),
    );
    
    return Scaffold(
      backgroundColor: greyLight,
      body: dataIsThere == false ? Center(
        child: CircularProgressIndicator(),
      ) : Stack(
        children: [
          clipPath,
          circleAvatar,
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                mySizedBox(300),
                Text(
                  name,
                  style: mystyle(40, black),
                  textAlign: TextAlign.center,
                ),
                mySizedBox(30),
                editProfileButton,
                mySizedBox(30),
                logoutButton,
              ],
            ),
          ),
        ],
      ),
    );
  }
}