import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

//------------------------------------------------------------------------
// Utility Function to quickly provide style to text
//------------------------------------------------------------------------
TextStyle mystyle(double size,[Color color = Colors.black, FontWeight fw = FontWeight.w700]){
  return GoogleFonts.montserrat(
    fontSize: size,
    color: color,
    fontWeight: fw
  );
}

//------------------------------------------------------------------------
// Utility Variable to grab user data from Firestore Database
//------------------------------------------------------------------------
CollectionReference userCollection = FirebaseFirestore.instance.collection('users');

//------------------------------------------------------------------------
// Utility function to provide Vertical Spacing
//------------------------------------------------------------------------
SizedBox mySizedBox (double height){
  return SizedBox(
    height: height,
  );
}