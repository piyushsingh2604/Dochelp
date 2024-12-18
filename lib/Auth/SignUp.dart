

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dochelp/Auth/Login.dart';
import 'package:dochelp/UI/Widgets/BottomBar.dart';
import 'package:dochelp/Worker/BottomBar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vibration/vibration.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _pass = TextEditingController();
  String name = "", email = "", pass = "", _userType = "";
  String? selectedUserType; // This will hold either 'Worker' or 'Client'

Future<void> signUp() async {
  if (pass.isNotEmpty) {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: pass);

      String uid = userCredential.user!.uid;

      await FirebaseFirestore.instance.collection('user').doc(uid).set({
        'username': name,
        'email': email,
        'uid': uid,
        'userType': _userType, // Store user type in Firestore
      });

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("SignUp is completed")));

      // Navigate based on user type
      if (_userType == 'Worker') {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => WorkerBottomBar( // Assuming you have WorkerBottomBar
            currentId: uid,
            ),
          ),
        );
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BottomBar(
              currentuid: uid,
              name: name,
            ),
          ),
        );
      }
    } on FirebaseException catch (e) {
      if (e.code == 'weak-password') {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Weak password")));
      } else if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Email already in use")));
      } else {
        print("An error occurred. Please try again.");
      }
    }
  }
}


  void setUserType(String userType) {
    setState(() {
      _userType = userType;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFFb61636),
                Color(0xFF731c3c),
                Color(0xFF341938),
              ],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                  left: 20,
                  top: 45,
                  child: Text(
                    "Create Your",
                    style: GoogleFonts.roboto(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w400),
                  )),
              Positioned(
                  left: 20,
                  top: 76,
                  child: Text(
                    "Account",
                    style: GoogleFonts.roboto(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w400),
                  )),
              Positioned(
                top: 160,
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(32),
                          topLeft: Radius.circular(32))),
                  child: Stack(
                    children: [
                      Positioned(
                          left: 30,
                          top: 50,
                          child: Text(
                            "Full Name",
                            style: TextStyle(
                              color: Color(0xFFB21837),
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          )),
                      Positioned(
                        top: 69,
                        left: 30,
                        right: 30,
                        child: TextField(
                          controller: _name,
                          style: TextStyle(color: Colors.grey),
                          cursorColor: Colors.grey[400],
                          cursorHeight: 16,
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 2.0),
                            ),
                            contentPadding: EdgeInsets.all(0.0),
                            isDense: true,
                          ),
                        ),
                      ),
                      Positioned(
                          left: 30,
                          top: 125,
                          child: Text(
                            "Gmail",
                            style: TextStyle(
                              color: Color(0xFFB21837),
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          )),
                      Positioned(
                        top: 140,
                        left: 30,
                        right: 30,
                        child: TextField(
                          controller: _email,
                          style: TextStyle(color: Colors.grey),
                          cursorColor: Colors.grey[400],
                          cursorHeight: 16,
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 2.0),
                            ),
                            contentPadding: EdgeInsets.all(0.0),
                            isDense: true,
                          ),
                        ),
                      ),
                      Positioned(
                          left: 30,
                          top: 190,
                          child: Text(
                            "Password",
                            style: TextStyle(
                              color: Color(0xFFB21837),
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          )),
                      Positioned(
                        top: 210,
                        left: 30,
                        right: 30,
                        child: TextField(
                          controller: _pass,
                          style: TextStyle(color: Colors.grey),
                          cursorColor: Colors.grey[400],
                          cursorHeight: 16,
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 2.0),
                            ),
                            contentPadding: EdgeInsets.all(0.0),
                            isDense: true,
                          ),
                        ),
                      ),
                     Positioned(
  top: 270,
  left: 20,  // Space on the left
  right: 20, // Space on the right
  child: Center(
    child: Row(
      children: [
        Expanded(
          child: InkWell(
            onTap: () {
              setUserType('Worker');
              setState(() {
                selectedUserType = 'Worker'; // Set the selected user type
              });
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10), // Remove horizontal padding
              decoration: BoxDecoration(
                color: selectedUserType == 'Worker' ? Color(0xFFb61636) : Colors.grey,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Center( // Center text within the button
                child: Text(
                  "Worker",
                  style: TextStyle(color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: 10), // Space between buttons
        Expanded(
          child: InkWell(
            onTap: () {
              setUserType('Client');
              setState(() {
                selectedUserType = 'Client'; // Set the selected user type
              });
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10), // Remove horizontal padding
              decoration: BoxDecoration(
                color: selectedUserType == 'Client' ? Color(0xFFb61636) : Colors.grey,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Center( // Center text within the button
                child: Text(
                  "Client",
                  style: TextStyle(color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  ),
),

                           
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 30,
                right: 30,
                top: 520,
                child: InkWell(
                  onTap: () async{
                      bool? hasVibrator = await Vibration.hasVibrator();
            if (hasVibrator == true) { // Check if hasVibrator is true
              Vibration.vibrate(duration: 100); // Vibrate for 1 second
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('This device cannot vibrate')),
              );
            }
                    Signupbutton();
                  },
                  child: Container(
                    height: 45,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color(0xFFb61636),
                            Color(0xFF731c3c),
                            Color(0xFF341938),
                          ],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                        borderRadius: BorderRadius.circular(30)),
                    child: Center(
                      child: Text(
                        "SIGN UP",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 18),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                  right: 28,
                  bottom: 50,
                  child: Text(
                    "Don't have an account?",
                    style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFFAEADB8)),
                  )),
              Positioned(
                  right: 28,
                  bottom: 30,
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Login(),
                          ));
                    },
                    child: Text(
                      "Sign in",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF281D3F)),
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  Future<void> Signupbutton() async {
    var value = _pass.text;
    var secondvalue = _email.text;
    var thirdvalue = _name.text;
    if (thirdvalue.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Enter name")));
    } else if (secondvalue.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Enter Gmail")));
    } else if (value.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Enter Password")));
    } else if (_userType.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Select user type")));
    } else {
      setState(() {
        email = _email.text;
        pass = _pass.text;
        name = _name.text;
      });
      signUp();
    }
  }
}
