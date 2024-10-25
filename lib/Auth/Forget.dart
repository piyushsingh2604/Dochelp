import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Forget extends StatefulWidget {
  const Forget({super.key});

  @override
  State<Forget> createState() => _ForgetState();
}

class _ForgetState extends State<Forget> {
  TextEditingController reset = TextEditingController();
  String _reset = "";
  final _formkey = GlobalKey<FormState>();

  resetfunction() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: _reset);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
          "No User Found for that Email",
          style: TextStyle(fontSize: 18.0, color: Colors.black),
        )));
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
                  right: 20,
                  top: 45,
                  child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: Colors.white,
                      ))),
              Positioned(
                  left: 20,
                  top: 45,
                  child: Text(
                    "Reset",
                    style: GoogleFonts.roboto(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w400),
                  )),
              Positioned(
                  left: 20,
                  top: 76,
                  child: Text(
                    "Password",
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
                          top: 70,
                          child: Text(
                            "Enter Gmail",
                            style: TextStyle(
                              color: Color(0xFFB21837),
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          )),
                      Positioned(
                        top: 89,
                        left: 30,
                        right: 30,
                        child: TextField(
                          controller: reset,
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
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 30,
                right: 30,
                top: 450,
                child: InkWell(
                  onTap: () {
                    setState(() {
                      _reset = reset.text;
                    });
                    resetfunction();
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
                        "Set Password",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 18),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
