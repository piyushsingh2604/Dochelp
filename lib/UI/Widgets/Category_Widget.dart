import 'package:dochelp/UI/Screens/About_Screen.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoryWidget extends StatelessWidget {
  String currentname;
  String uid;
  CategoryWidget({super.key, required this.uid, required this.currentname});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _buildSpecialistContainer(
              context, 'Salon', Icons.self_improvement_rounded),
          Gap(10),
          _buildSpecialistContainer(context, 'Workes', Icons.person),
          Gap(10),
          _buildSpecialistContainer(
              context, 'Hair Dresser', Icons.person_search_rounded),
          Gap(10),
          _buildSpecialistContainer(context, 'Spa', Icons.shower),
          Gap(10),
          _buildSpecialistContainer(
              context, 'Nails', Icons.airline_seat_legroom_reduced_rounded),
          Gap(10),
        ],
      ),
    );
  }

  Widget _buildSpecialistContainer(
      BuildContext context, String profession, IconData icon) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SalonListScreen(
              uid: uid,
              profession: profession, currentname: currentname,
            ),
          ),
        );
      },
      child: Container(
        height: 73,
        width: 72,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(22),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 9),
              child: SizedBox(
                height: 35,
                width: 30,
                child: Center(
                  child: Icon(
                    icon,
                    size: 27,
                    color: Color(0xFF2C41FF),
                  ),
                ),
              ),
            ),
            Gap(3),
            Text(
              profession,
              style:
                  GoogleFonts.roboto(fontSize: 9, fontWeight: FontWeight.w400),

              // style: TextStyle(
              //   color: const Color.fromARGB(202, 0, 0, 0),
              //   fontSize: 10,
              //   fontWeight: FontWeight.w100,
              // ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getColorForProfession(String profession) {
    return Colors.transparent; // All professions return transparent
  }
}

class SalonListScreen extends StatelessWidget {
  final String profession;
  final String uid;
  final String currentname;

  const SalonListScreen({
    super.key,
    required this.profession,
    required this.uid,
    required this.currentname
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFF7F8F9),
        title: Text(profession),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('user').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          final docs = snapshot.data!.docs.where((user) {
            var data = user.data();
            return data['profession'] == profession;
          }).toList();

          if (docs.isEmpty) {
            return Center(child: Text('No one found for this profession.'));
          }

          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (context, index) {
              final user = docs[index];
              var userid = user.id;
              var data = user.data();
               final images = data['images'] is List<dynamic> ? data['images'] as List<dynamic> : [];
  final profileImageUrl = images.isNotEmpty
      ? images[0]
      : 'https://cdn-icons-png.flaticon.com/512/9203/9203764.png'; // Default image URL

              return Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AboutScreen(
                          currentname: currentname,
                          userId: uid,
                          userInfo: userid,
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
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(15),
                              image: DecorationImage(
                              image: NetworkImage(profileImageUrl), // Placeholder image
                                fit: BoxFit.cover,
                              ),
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
                                 '${data['averageRating'] ?? "1"}',
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
        },
      ),
    );
  }
}
