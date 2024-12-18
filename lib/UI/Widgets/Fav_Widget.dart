import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dochelp/UI/Screens/About_Screen.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class FavWidget extends StatefulWidget {
  // Change to StatefulWidget
  final String userId;
  String currentname;

   FavWidget({super.key, required this.userId,required this.currentname});

  @override
  _FavWidgetState createState() => _FavWidgetState();
}

class _FavWidgetState extends State<FavWidget> {
  Future<List<Map<String, dynamic>>> _getFavorites() async {
    final userDoc = await FirebaseFirestore.instance
        .collection('user')
        .doc(widget.userId)
        .get();

    if (userDoc.exists) {
      List<String> favoriteIds =
          List<String>.from(userDoc.data()!['favorites'] ?? []);
      List<Map<String, dynamic>> favoritesDetails = [];
      for (String favoriteId in favoriteIds) {
        final favoriteDoc = await FirebaseFirestore.instance
            .collection('user')
            .doc(favoriteId)
            .get();
        if (favoriteDoc.exists) {
          favoritesDetails.add({
            'id': favoriteId, // Store the ID for later removal
            ...favoriteDoc.data() as Map<String, dynamic>,
          });
        }
      }
      return favoritesDetails;
    }
    return [];
  }

  Future<void> _removeFavorite(String favoriteId) async {
    final docRef =
        FirebaseFirestore.instance.collection('user').doc(widget.userId);

    // Get the current favorites for the user
    final docSnapshot = await docRef.get();

    if (docSnapshot.exists) {
      List<dynamic> favorites = docSnapshot.data()!['favorites'] ?? [];
      favorites.remove(favoriteId); // Remove the favorite

      await docRef.update({'favorites': favorites});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _getFavorites(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("No favorites yet."));
          }

          final favorites = snapshot.data!;
          return ListView.builder(
            itemCount: favorites.length,
            itemBuilder: (context, index) {
              var favorite = favorites[index];

              return GestureDetector(
                onTap: () {
                  // Navigate to the detail screen
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AboutScreen(
                        currentname: widget.currentname,
                          userInfo: favorite['id'], userId: widget.userId),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 7),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(19),
                      color: Colors.white,
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          left: 10,
                          top: 11,
                          child: Container(
                            height: 77,
                            width: 77,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: const Color.fromARGB(73, 76, 175, 79),
                              image: DecorationImage(
                                image: NetworkImage(
                                    favorite['images'] is List &&
                                            favorite['images'].isNotEmpty
                                        ? favorite['images'][0]
                                        : 'path_to_default_image' // Provide a default image path here
                                    ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 100,
                          top: 19,
                          child: Text(
                            favorite['username'] ?? 'Unknown',
                            style: GoogleFonts.openSans(
                                fontSize: 15, fontWeight: FontWeight.w600),
                          ),
                        ),
                        Positioned(
                          left: 100,
                          top: 45,
                          child: Text(
                            favorite['profession'] ?? 'Unknown',
                            style: GoogleFonts.roboto(
                                fontSize: 10, fontWeight: FontWeight.w400),
                          ),
                        ),
                        Positioned(
                          top: 5,
                          right: 5,
                          child: IconButton(
                            onPressed: () async {
                              await _removeFavorite(
                                  favorite['id']); // Remove the favorite
                              setState(
                                  () {}); // Rebuild the widget to reflect changes
                            },
                            icon: Icon(
                              Icons.favorite,
                              color: Color(0xFFF31D53),
                              size: 19,
                            ),
                          ),
                        ),
                        Positioned(
                          top: 70,
                          left: 100,
                          child: Row(
                            children: [
                              Icon(
                                Icons.star,
                                size: 17,
                                color: Colors.yellow[600],
                              ),
                              Gap(4),
                              Text(
                                favorite['averageRating']?.toString() ?? '1',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w100,
                                ),
                              ),
                             
                            ],
                          ),
                        ),
                        Positioned(
                          top: 70,
                          right: 20,
                          child: Text(
                            "\$${favorite['charge_per_hour'] ?? '0'}/hr",
                            style: GoogleFonts.roboto(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFFF31D53),
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
