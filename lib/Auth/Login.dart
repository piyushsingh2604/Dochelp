import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dochelp/Auth/Forget.dart';
import 'package:dochelp/Auth/SignUp.dart';
import 'package:dochelp/UI/Widgets/BottomBar.dart';
import 'package:dochelp/Worker/BottomBar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vibration/vibration.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _pass = TextEditingController();
  String email = '', pass = '';
  Signin() async {
    if (pass.isNotEmpty) {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: pass);

        String uid = userCredential.user!.uid;

        DocumentSnapshot userdoc =
            await FirebaseFirestore.instance.collection('user').doc(uid).get();

        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Login complete")));

        String username = userdoc['username'];
        String userid = userdoc['uid'];
        String userType = userdoc['userType']; // Retrieve userType

        // Navigate based on userType
        if (userType == 'Worker') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => WorkerBottomBar(
                currentId: userid,
              ),
            ),
          );
        } else if (userType == 'Client') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  BottomBar(currentuid: userid, name: username),
            ),
          );
        } else {
          // Handle unexpected userType
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("Invalid user type.")));
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'wrong-password') {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("The password is wrong.")));
        } else {
          print("An error occurred. Please try again.");
        }
      }
    }
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
                    "Hello",
                    style: GoogleFonts.roboto(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w400),
                  )),
              Positioned(
                  left: 20,
                  top: 76,
                  child: Text(
                    "Sign in!",
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
                            "Gmail",
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
                          controller: _email,
                          style: TextStyle(color: Colors.grey),
                          cursorColor: Colors.grey[400],
                          cursorHeight: 16,
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.grey), // Grey bottom border
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.grey,
                                  width: 2.0), // Thicker border when focused
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
                            "Password",
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
                          controller: _pass,
                          obscureText: true,
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
                        right: 30,
                        top: 190,
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Forget(),
                                ));
                          },
                          child: Text(
                            "Forgot password?",
                            style: GoogleFonts.roboto(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF564E64)),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 30,
                right: 30,
                top: 440,
                child: InkWell(
                  onTap: () async {
                    bool? hasVibrator = await Vibration.hasVibrator();
                    if (hasVibrator == true) {
                      // Check if hasVibrator is true
                      Vibration.vibrate(duration: 100); // Vibrate for 1 second
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('This device cannot vibrate')),
                      );
                    }
                    loginbutton();
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
                        "SIGN IN",
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
                    "Don't have account?",
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
                              builder: (context) => SignUp(),
                            ));
                      },
                      child: Text(
                        "Sign up",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF281D3F)),
                      )))
            ],
          ),
        ),
      ),
    );
  }

  Future<void> loginbutton() async {
    var value = _pass.text;
    var secondvalue = _email.text;

    if (secondvalue.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Enter Gmail")));
    }
    if (value.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Enter Password")));
    } else {
      setState(() {
        email = _email.text;
        pass = _pass.text;
      });
      Signin();
    }
  }
}
