import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dochelp/Worker/EditProfile_Widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WorkerProfile extends StatefulWidget {
  const WorkerProfile({super.key});

  @override
  State<WorkerProfile> createState() => _WorkerProfileState();
}

class _WorkerProfileState extends State<WorkerProfile> {
  final currentuser = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(automaticallyImplyLeading: false,
          backgroundColor: Color(0xFFF42F5A),
          elevation: 0,
          centerTitle: true,
          title: Text(
            "My Profile",
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.w500, fontSize: 17),
          ),
        ),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('user')
              .where('uid', isEqualTo: currentuser.currentUser!.uid)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text("Error ${snapshot.hasError}"),
              );
            } else if (snapshot.hasData) {
              final docs = snapshot.data!.docs;
              return ListView.builder(
                itemCount: docs.length,
                itemBuilder: (context, index) {
                  var data = docs[index].data();
                  return SingleChildScrollView(
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
                                left:
                                    MediaQuery.of(context).size.width / 2 - 60,
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
                                          image: DecorationImage(
                                            image: NetworkImage(
                                              (data['images'] is List &&
                                                      data['images'].isNotEmpty)
                                                  ? data['images'][0]
                                                  : '',
                                            ),
                                            fit: BoxFit.cover,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(124)),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                  left: MediaQuery.of(context).size.width / 2 -
                                      55,
                                  top: 146,
                                  child: Text(
                                    data['name'] ?? "",
                                    style: GoogleFonts.roboto(
                                        color: Colors.black,
                                        fontSize: 19,
                                        fontWeight: FontWeight.w600),
                                  )),
                              Positioned(
                                top: 174,
                                left:
                                    MediaQuery.of(context).size.width / 2 - 30,
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              EditProfileWidget(gmail: data['email']??"",name: data['username']??'',),
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
                          padding: const EdgeInsets.only(
                              left: 14, right: 14, top: 20),
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
                                      data['username'] ?? "",
                                      style: GoogleFonts.roboto(
                                          color: const Color.fromARGB(
                                              187, 0, 0, 0),
                                          fontWeight: FontWeight.w500,
                                          fontSize: 11.5),
                                    )),
                                Positioned(
                                    left: 25,
                                    top: 6.5,
                                    child: Text(
                                      "FULL NAME",
                                      style: GoogleFonts.roboto(
                                          color: Color(0xFF76777C),
                                          fontSize: 8),
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
                          padding: const EdgeInsets.only(
                              left: 14, right: 14, top: 8),
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
                                      data['email'] ?? "",
                                      style: GoogleFonts.roboto(
                                          color: const Color.fromARGB(
                                              187, 0, 0, 0),
                                          fontWeight: FontWeight.w500,
                                          fontSize: 11.5),
                                    )),
                                Positioned(
                                    left: 25,
                                    top: 6.5,
                                    child: Text(
                                      "EMAIL ADDRESS",
                                      style: GoogleFonts.roboto(
                                          color: Color(0xFF76777C),
                                          fontSize: 8),
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
                          padding: const EdgeInsets.only(
                              left: 14, right: 14, top: 8),
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
                                      data['number'] ?? "",
                                      style: GoogleFonts.roboto(
                                          color: const Color.fromARGB(
                                              187, 0, 0, 0),
                                          fontWeight: FontWeight.w500,
                                          fontSize: 11.5),
                                    )),
                                Positioned(
                                    left: 25,
                                    top: 6.5,
                                    child: Text(
                                      "MOBILE NUMBER",
                                      style: GoogleFonts.roboto(
                                          color: Color(0xFF76777C),
                                          fontSize: 8),
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
                          padding: const EdgeInsets.only(
                              left: 14, right: 14, top: 8),
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
                                      data['location'] ?? "",
                                      style: GoogleFonts.roboto(
                                          color: const Color.fromARGB(
                                              187, 0, 0, 0),
                                          fontWeight: FontWeight.w500,
                                          fontSize: 11.5),
                                    )),
                                Positioned(
                                    left: 25,
                                    top: 6.5,
                                    child: Text(
                                      "STORE LOCATION",
                                      style: GoogleFonts.roboto(
                                          color: Color(0xFF76777C),
                                          fontSize: 8),
                                    )),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            } else {
              return Center(
                child: Text("No data found"),
              );
            }
          },
        ));
  }
}



//https://i.pinimg.com/736x/0a/cb/e1/0acbe12b9ad4bddb88ae87ab32a04c88.jpg