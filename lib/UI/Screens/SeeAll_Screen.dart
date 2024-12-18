import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dochelp/UI/Screens/About_Screen.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class SeeallScreen extends StatelessWidget {
  String currentname;
  String userId;
  SeeallScreen({super.key, 
    required this.currentname,
    required this.userId,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(      backgroundColor: Color(0xFFF7F8F9),

      appBar: AppBar(      backgroundColor: Color(0xFFF7F8F9),

        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios_new_rounded)),
            title: Text("All Workers"),
            centerTitle: true,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('user').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text("error ${snapshot.hasError}"),
            );
          } else if (snapshot.hasData) {
            final docs = snapshot.data!.docs;
            final filteredDocs = docs.where((doc) {
              var data = doc.data();
              return data['profession'] != null &&
                  data['profession'].isNotEmpty;
            }).toList();

            return ListView.builder(
              itemCount: filteredDocs.length,
              itemBuilder: (context, index) {
                var data = filteredDocs[index].data();
                var useruid = filteredDocs[index].id;

                return Padding(
                  padding: const EdgeInsets.only(top: 6, left: 20, right: 20),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AboutScreen(
                            currentname: currentname,
                            userId: userId,
                            userInfo: useruid,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      height: 60,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(17),
                        color: Colors.white,
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                            left: 6,
                            top: 5,
                            child: Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: data['images'] is List
                                        ? NetworkImage(data['images'][
                                            0]) // Use the first image in the list
                                        : NetworkImage(data['images'] ?? 'https://cdn-icons-png.flaticon.com/512/3135/3135715.png'),
                                    fit: BoxFit.cover),
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                          ),
                          Positioned(
                            left: 67,
                            top: 5,
                            child: Text(
                              data['username'] ?? "",
                              style: GoogleFonts.montserrat(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Positioned(
                            left: 67,
                            top: 33,
                            child: Text(
                              data['profession'] ?? "",
                              style: GoogleFonts.montserrat(
                                fontSize: 11,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          Positioned(
                            top: 10,
                            right: 15,
                            child: SizedBox(
                              height: 40,
                              child: Row(
                                children: [
                                  Container(
                                    height: 15,
                                    width: 15,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(
                                          'assets/pngtree-glossy-yellow-star-hd-image-vector-png-image_7108442.png',
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Gap(4),
                                  Text(
                                    "4.9",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w100,
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
                );
              },
            );
          } else {
            return Center(
              child: Text("No data found"),
            );
          }
        },
      ),
    );
  }
}
