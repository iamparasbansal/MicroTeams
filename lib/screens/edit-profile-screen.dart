import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:microteams/screens/auth-screen.dart';
import 'package:microteams/screens/home-page.dart';
import 'package:microteams/theme/app-colors.dart';
import 'package:microteams/utils/variables.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  @override
  void initState() {
    super.initState();
    getUserData();
  }

  bool dataIsThere = false;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  bool isInProgress = false;
  final auth = FirebaseAuth.instance;

  //------------------------------------------------------------------------
  // Function to get User Data from Firestore Database
  //------------------------------------------------------------------------
  getUserData() async {
    DocumentSnapshot userDoc =
        await userCollection.doc(FirebaseAuth.instance.currentUser!.uid).get();
    setState(() {
      nameController.text = (userDoc.data() as dynamic)['name'];
      emailController.text = (userDoc.data() as dynamic)['email'];
      dataIsThere = true;
    });
  }

  _showAlertDialog(errorMsg) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'Update Failed',
            style: TextStyle(color: black),
          ),
          content: Text(errorMsg),
        );
      }
    );
  }

   _showAlertDialogChangePassword(errorTitle, errorMsg) {
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
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      }
    );
  }

  //------------------------------------------------------------------------
  // This function hadles the click on Change Password Button
  //------------------------------------------------------------------------
  _changePassword() async {
    DocumentSnapshot userDoc =
      await userCollection.doc(FirebaseAuth.instance.currentUser!.uid).get();
    setState(() {
      isInProgress = true;
    });
    auth.sendPasswordResetEmail(email: (userDoc.data() as dynamic)['email']);
    setState(() {
      isInProgress = false;
    });
    _showAlertDialogChangePassword(
      "Link sent", 
      "Please click the link sent on your email and continue to change the password."
    );
  }

  //------------------------------------------------------------------------
  // Function to update User Data in Firestore Database
  //------------------------------------------------------------------------
  editProfile() async {
    if (nameController.text == '' || emailController.text == '') {
      _showAlertDialog("All fields are required. Please fill them all.");
    } else {
      userCollection
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({'name': nameController.text, 'email': emailController.text});
      Navigator.push(
        context, MaterialPageRoute(
          builder: (context) => HomePage()
        )
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var editProfileText = Container(
        padding: EdgeInsets.only(left: 30, right: 30, bottom: 10),
        child: Text(
          "Edit the field you want to update and click update now.",
          style: mystyle(20, black, FontWeight.w400),
          textAlign: TextAlign.center,
        ));

    var orText = Container(
      padding: EdgeInsets.only(left: 30, right: 30, bottom: 10),
      child: Text(
        "OR",
        style: mystyle(20, black, FontWeight.w600),
        textAlign: TextAlign.center,
      )
    );

    var updateNowButton = InkWell(
      onTap: () {
        editProfile();
      },
      child: Container(
        width: MediaQuery.of(context).size.width / 1.4,
        height: 40,
        decoration: BoxDecoration(
            color: blueSecondary, borderRadius: BorderRadius.circular(10)),
        child: Center(
          child: Text(
            "Update Now",
            style: mystyle(17, white),
          ),
        ),
      ),
    );

    //------------------------------------------------------------------------
    var changePasswordButton = InkWell(
      onTap: () {
        _changePassword();
      },
      child: Container(
        width: MediaQuery.of(context).size.width / 1.4,
        height: 40,
        decoration: BoxDecoration(
            color: blueSecondary, borderRadius: BorderRadius.circular(10)),
        child: Center(
          child: Text(
            "Change Password",
            style: mystyle(17, white),
          ),
        ),
      ),
    );

    // Name Text Field to get user input of new Name of user
    //------------------------------------------------------------------------
    var nameTextField = Container(
      width: MediaQuery.of(context).size.width / 1.4,
      height: 42,
      child: TextField(
        style: mystyle(18, black, FontWeight.w400),
        keyboardType: TextInputType.emailAddress,
        controller: nameController,
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

    var emailTextField = Container(
      width: MediaQuery.of(context).size.width / 1.4,
      height: 42,
      child: TextField(
        style: mystyle(18, black, FontWeight.w400),
        keyboardType: TextInputType.emailAddress,
        controller: emailController,
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
            hintText: "Email",
            hintStyle: mystyle(18, grey, FontWeight.w400)),
      ),
    );

    //------------------------------------------------------------------------
    // User Profile Pic Container
    //------------------------------------------------------------------------
    var circleAvatar = Container(
        margin: EdgeInsets.only(
          left: (MediaQuery.of(context).size.width / 2) - 50,
          top: MediaQuery.of(context).size.height / 5.5,
        ),
        child: Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            color: greyLight,
            shape: BoxShape.circle,
            image: DecorationImage(
              image: AssetImage('images/profile.png'),
            ),
          ),
        ));

    //------------------------------------------------------------------------
    // Circular blue Clip at Top of Edit Profile Page
    //------------------------------------------------------------------------
    var clipPath = ClipPath(
      clipper: OvalBottomBorderClipper(),
      child: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height / 4,
        decoration: BoxDecoration(color: blueSecondary),
      ),
    );

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: greyLight,
      body: dataIsThere == false
          ? Center(
              child: CircularProgressIndicator(
                color: blueSecondary,
              ),
            )
          : Column(
              children: [
                Stack(
                  children: [
                    clipPath,
                    circleAvatar,
                  ],
                ),
                Container(
                  child: Column(
                    children: [
                      mySizedBox(40),
                      editProfileText,
                      mySizedBox(20),
                      nameTextField,
                      mySizedBox(20),
                      emailTextField,
                      mySizedBox(20),
                      updateNowButton,
                      mySizedBox(20),
                      orText,
                      mySizedBox(20),
                      changePasswordButton,
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
