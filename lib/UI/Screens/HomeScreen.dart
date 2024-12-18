
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dochelp/UI/Screens/About_Screen.dart';
import 'package:dochelp/UI/Screens/SeeAll_Screen.dart';
import 'package:dochelp/UI/Widgets/Category_Widget.dart';
import 'package:dochelp/UI/Widgets/Swiper_Widget.dart';
import 'package:dochelp/UI/Widgets/TopWorkes_Widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  final String name;
  final String uid;

  const HomeScreen({super.key, required this.uid, required this.name});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? imageUrl;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

 Future<void> fetchUserData() async {
  try {
    DocumentSnapshot userDoc = await FirebaseFirestore.instance
        .collection('user')
        .doc(widget.uid)
        .get();

    if (userDoc.exists) {
      setState(() {
        List<dynamic> images = userDoc['images'] ?? [''];
        imageUrl = images.isNotEmpty ? images[0] : null;
      });
    } else {
      print("User document does not exist");
      // Handle case where document doesn't exist, maybe show an error message
    }
  } catch (e) {
    print("Error fetching user data: $e");
    // Handle error, possibly show a dialog to the user
  }
}

  Future<List<Map<String, dynamic>>> fetchUsernames(String query) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('user')
        .where('username', isGreaterThanOrEqualTo: query)
        .limit(5)
        .get();

    return querySnapshot.docs
        .map((doc) => {
              'username': doc['username'],
              'userId': doc.id,
            })
        .toList();
  }

  void navigateToAboutScreen(String userId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AboutScreen(
          userId: widget.uid,
          userInfo: userId,
          currentname: widget.name,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF7F8F9),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 410,
              width: MediaQuery.of(context).size.width,
              child: Stack(
                children: [
                  Positioned(
                    top: 59,
                    left: 20,
                    child: Text(
                      "Keep Healthy!",
                      style: GoogleFonts.roboto(
                          fontSize: 25, fontWeight: FontWeight.w600),
                    ),
                  ),
                  Positioned(
                    top: 40,
                    left: 20,
                    child: Text(
                      "Hello ${widget.name}",
                      style: GoogleFonts.roboto(
                          fontSize: 14, fontWeight: FontWeight.w300),
                    ),
                  ),
                  Positioned(
                    top: 30,
                    right: 20,
                    child: Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(60),
                        image: imageUrl != null
                            ? DecorationImage(
                                image: NetworkImage(imageUrl!),
                                fit: BoxFit.cover,
                              )
                            : DecorationImage(
                                image: NetworkImage("https://cdn-icons-png.flaticon.com/512/3135/3135715.png"),
                                fit: BoxFit.cover,
                              ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 20,
                    right: 20,
                    top: 110,
                    child: SizedBox(
                      height: 45,
                      child: Autocomplete<Map<String, dynamic>>(
                        optionsBuilder:
                            (TextEditingValue textEditingValue) async {
                          // Show suggestions only if there's input
                          if (textEditingValue.text.isEmpty) {
                            return const Iterable<Map<String, dynamic>>.empty();
                          }
                          return await fetchUsernames(textEditingValue.text);
                        },
                        displayStringForOption: (Map<String, dynamic> option) =>
                            option['username'],
                        onSelected: (Map<String, dynamic> selection) {
                          navigateToAboutScreen(selection['userId']);
                        },
                        fieldViewBuilder: (context, textEditingController,
                            focusNode, onFieldSubmitted) {
                          return Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color:
                                    const Color.fromARGB(223, 255, 255, 255)),
                            height: 45,
                            width: MediaQuery.of(context).size.width,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 20, bottom: 16),
                              child: TextField(
                                controller: textEditingController,
                                cursorHeight: 16,
                                focusNode: focusNode,
                                decoration: InputDecoration(
                                  hintText: 'Search Salon or anything',
                                  hintStyle: GoogleFonts.poppins(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w300),
                                  border: InputBorder.none,
                                ),
                                onChanged: (value) {
                                  // Update the suggestions when the text changes
                                  setState(() {});
                                },
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  Positioned(
                    top: 170,
                    left: 20,
                    right: 20,
                    child: SizedBox(
                      height: 145,
                      width: MediaQuery.of(context).size.width,
                      child: Slider_Widget(),
                    ),
                  ),
                  Positioned(
                    right: 10,
                    left: 20,
                    top: 330,
                    child: SizedBox(
                      height: 73,
                      width: MediaQuery.of(context).size.width,
                      child: CategoryWidget(
                        currentname: widget.name,
                        uid: widget.uid,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 1, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Top Salons",
                    style: GoogleFonts.notoSansGurmukhi(
                        fontSize: 19, fontWeight: FontWeight.w600),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SeeallScreen(
                                currentname: widget.name, userId: widget.uid),
                          ));
                    },
                    child: Text(
                      "See All",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF2C41FF),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 3),
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: TopworkesWidget(
                  currentname: widget.name,
                  userId: widget.uid,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
