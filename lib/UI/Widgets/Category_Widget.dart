import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _buildSpecialistContainer(context, 'Salon', Icons.self_improvement_rounded),
          Gap(10),
          _buildSpecialistContainer(context, 'Workes', Icons.person),
          Gap(10),
          _buildSpecialistContainer(context, 'Hair Dresser', Icons.person_search_rounded),
          Gap(10),
          _buildSpecialistContainer(context, 'Spa', Icons.shower),
          Gap(10),
          _buildSpecialistContainer(context, 'Nails', Icons.airline_seat_legroom_reduced_rounded),
          Gap(10),
        ],
      ),
    );
  }

  Widget _buildSpecialistContainer(BuildContext context, String profession, IconData icon) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SalonListScreen(
              uid: '',
              profession: profession,
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
                                      style: GoogleFonts.roboto(fontSize: 9,fontWeight: FontWeight.w400),

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

  const SalonListScreen({
    super.key,
    required this.profession,
    required this.uid,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: Text('$profession Doctors'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('Users').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          final docs = snapshot.data!.docs.where((user) {
            var data = user.data();
            return data['profession'] == profession;
          }).toList();

          if (docs.isEmpty) {
            return Center(child: Text('No doctors found for this profession.'));
          }

          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (context, index) {
              final user = docs[index];
              final userid = user.id;
              var data = user.data();
              return ListTile(
                title: Text(data['name'] ?? ''),
                onTap: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => Aboutscreen(
                  //       userid: userid,
                  //       currentid: uid,
                  //     ),
                  //   ));
                },
              );
            },
          );
        },
      ),
    );
  }
}
