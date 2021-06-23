import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:microteams/screens/home-page.dart';
import 'package:microteams/screens/profile-screen.dart';
import 'package:microteams/theme/app-colors.dart';
import 'package:microteams/utils/variables.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({ Key? key }) : super(key: key);

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {

  String name = "";
  TextEditingController nameController  = TextEditingController();


  //------------------------------------------------------------------------
  // Function to update User Data in Firestore Database
  //------------------------------------------------------------------------
  editProfile() async {
    userCollection.doc(FirebaseAuth.instance.currentUser!.uid).update({
      'name': nameController.text
    });
    setState(() {
      name = nameController.text;
    });
    Navigator.push(
      context, 
      MaterialPageRoute(
        builder: (context)=> HomePage()
      )
    );
  }
  
  @override
  Widget build(BuildContext context) {

    var updateNowButton = InkWell(
      onTap: (){
        editProfile();
      },
      child: Container(
        width: MediaQuery.of(context).size.width/1.4,
        height: 40,
        decoration: BoxDecoration(
          color: purpleSecondary,
          borderRadius: BorderRadius.circular(10)
        ),
        child: Center(
          child: Text(
            "Update Now",
            style: mystyle(17, white),
          ),
        ),
      ),
    );

    //------------------------------------------------------------------------
    // Name Text Field to get user input of new name of user
    //------------------------------------------------------------------------
    var nameTextField = Container(
      width: MediaQuery.of(context).size.width/1.4,
      height: 42,
      child: TextField(
        style: mystyle(18, black, FontWeight.w400),
        keyboardType: TextInputType.emailAddress,
        controller: nameController,
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
          hintText: "Name",
          hintStyle: mystyle(18, grey, FontWeight.w400)
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
    // Circular Purple Clip at Top of Edit Profile Page
    //------------------------------------------------------------------------
    var clipPath = ClipPath(
      clipper: OvalBottomBorderClipper(),
      child: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height/2.5,
        decoration: BoxDecoration(
          color: purpleSecondary
        ),
      ),
    );
    
    return Scaffold(
      backgroundColor: greyLight,
      body: Stack(
        children: [
          clipPath,
          circleAvatar,
           Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                mySizedBox(300),
                nameTextField,
                mySizedBox(20),
                updateNowButton,
              ],
            ),
          ),
        ],
      ),
    );
  }
}