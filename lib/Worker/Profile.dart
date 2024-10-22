import 'package:dochelp/Worker/EditProfile_Widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WorkerProfile extends StatefulWidget {
  const WorkerProfile({super.key});

  @override
  State<WorkerProfile> createState() => _WorkerProfileState();
}

class _WorkerProfileState extends State<WorkerProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xFFF42F5A),
        elevation: 0,
        centerTitle: true,
        title: Text(
          "My Profile",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w500, fontSize: 17),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 190,
              width: MediaQuery.of(context).size.width,
              child: Stack(
                children: [
                  Container(
                    height: 100,
                    width: MediaQuery.of(context).size.width,
                    color: Color(0xFFF42F5A),
                  ),
                  Positioned(
                    left: MediaQuery.of(context).size.width / 2 - 60,
                    top: 10,
                    child: Container(
                      height: 130,
                      width: 130,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(130)),
                      child: Center(
                        child: Container(
                          height: 122,
                          width: 122,
                          decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(124)),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                      left: MediaQuery.of(context).size.width / 2 - 60,
                      top: 146,
                      child: Text(
                        "Stayam Panday",
                        style: GoogleFonts.roboto(
                            color: Colors.black,
                            fontSize: 19,
                            fontWeight: FontWeight.w600),
                      )),
                  Positioned(
                    top: 174,
                    left: MediaQuery.of(context).size.width / 2 - 30,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditprofileWidget(),
                            ));
                      },
                      child: Row(
                        children: [
                          Text(
                            "Edit Profile",
                            style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFFD89CAE)),
                          ),
                          Icon(
                            Icons.edit,
                            size: 11,
                            color: Color(0xFFD89CAE),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 14, right: 14, top: 20),
              child: Container(
                color: Colors.white,
                height: 48,
                width: MediaQuery.of(context).size.width,
                child: Stack(
                  children: [
                    Positioned(
                      left: 1,
                      top: 16.8,
                      child: Icon(
                        Icons.person,
                        size: 17.5,
                        color: Color(0xFFBEB9B9),
                      ),
                    ),
                    Positioned(
                        left: 25,
                        top: 19.5,
                        child: Text(
                          "Satyam Panday",
                          style: GoogleFonts.roboto(
                              color: const Color.fromARGB(187, 0, 0, 0),
                              fontWeight: FontWeight.w500,
                              fontSize: 11.5),
                        )),
                    Positioned(
                        left: 25,
                        top: 6.5,
                        child: Text(
                          "FULL NAME",
                          style: GoogleFonts.roboto(
                              color: Color(0xFF76777C), fontSize: 8),
                        )),
                  ],
                ),
              ),
            ),
            Divider(
              thickness: 1.1,
              color: Color.fromARGB(70, 190, 185, 185),
              indent: 15,
              endIndent: 15,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 14, right: 14, top: 8),
              child: Container(
                color: Colors.white,
                height: 48,
                width: MediaQuery.of(context).size.width,
                child: Stack(
                  children: [
                    Positioned(
                      left: 1,
                      top: 16.8,
                      child: Icon(
                        Icons.email_outlined,
                        size: 17.5,
                        color: Color(0xFFBEB9B9),
                      ),
                    ),
                    Positioned(
                        left: 25,
                        top: 19.5,
                        child: Text(
                          "SatyamPanday@gmail.com",
                          style: GoogleFonts.roboto(
                              color: const Color.fromARGB(187, 0, 0, 0),
                              fontWeight: FontWeight.w500,
                              fontSize: 11.5),
                        )),
                    Positioned(
                        left: 25,
                        top: 6.5,
                        child: Text(
                          "EMAIL ADDRESS",
                          style: GoogleFonts.roboto(
                              color: Color(0xFF76777C), fontSize: 8),
                        )),
                  ],
                ),
              ),
            ),
            Divider(
              thickness: 1.1,
              color: Color.fromARGB(70, 190, 185, 185),
              indent: 15,
              endIndent: 15,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 14, right: 14, top: 8),
              child: Container(
                color: Colors.white,
                height: 48,
                width: MediaQuery.of(context).size.width,
                child: Stack(
                  children: [
                    Positioned(
                      left: 1,
                      top: 16.8,
                      child: Icon(
                        Icons.call_outlined,
                        size: 17.5,
                        color: Color(0xFFBEB9B9),
                      ),
                    ),
                    Positioned(
                        left: 25,
                        top: 19.5,
                        child: Text(
                          "+91 8982209188",
                          style: GoogleFonts.roboto(
                              color: const Color.fromARGB(187, 0, 0, 0),
                              fontWeight: FontWeight.w500,
                              fontSize: 11.5),
                        )),
                    Positioned(
                        left: 25,
                        top: 6.5,
                        child: Text(
                          "MOBILE NUMBER",
                          style: GoogleFonts.roboto(
                              color: Color(0xFF76777C), fontSize: 8),
                        )),
                  ],
                ),
              ),
            ),
            Divider(
              thickness: 1.1,
              color: Color.fromARGB(70, 190, 185, 185),
              indent: 15,
              endIndent: 15,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 14, right: 14, top: 8),
              child: Container(
                color: Colors.white,
                height: 130,
                width: MediaQuery.of(context).size.width,
                child: Stack(
                  children: [
                    Positioned(
                      left: 1,
                      top: 26.5,
                      child: Icon(
                        Icons.location_on_outlined,
                        size: 17.5,
                        color: Color(0xFFBEB9B9),
                      ),
                    ),
                    Positioned(
                        right: 25,
                        left: 25,
                        top: 19.5,
                        child: Text(
                          "n md cmnxnjln djlsnfcnmdfcjnjlndsjnjcnxz jnfdsjcjxznjkcnjks njlsdnjln zjxnws jnsdnx kz  jkledsnmlknxjnj jkfnwjdsnjxn jknjkns",
                          style: GoogleFonts.roboto(
                              color: const Color.fromARGB(187, 0, 0, 0),
                              fontWeight: FontWeight.w500,
                              fontSize: 11.5),
                        )),
                    Positioned(
                        left: 25,
                        top: 6.5,
                        child: Text(
                          "STORE LOCATION",
                          style: GoogleFonts.roboto(
                              color: Color(0xFF76777C), fontSize: 8),
                        )),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}



//https://i.pinimg.com/736x/0a/cb/e1/0acbe12b9ad4bddb88ae87ab32a04c88.jpg