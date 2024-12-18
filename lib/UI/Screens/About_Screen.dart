import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher_string.dart';

class AboutScreen extends StatefulWidget {
  String currentname;
  String userId;
  String userInfo;
  AboutScreen({
    super.key,
    required this.userId,
    required this.userInfo,
    required this.currentname,
  });
  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  double rating = 0.0; // Current rating value

  DateTime currentDate = DateTime.now();
  DateTime? selectedDate;
  List<DateTime> selectableDates = [];
  String? selectedTime;
  List<String> selectableTimes = [];
  bool isFavorite = false; // Track favorite status

  @override
  void initState() {
    super.initState();
    _generateSelectableDates();
    _generateSelectableTimes();
    _checkFavoriteStatus(); // Check if the item is a favorite
  }

  void _generateSelectableDates() {
    selectableDates = List.generate(5, (index) {
      return DateTime.now().add(Duration(days: index));
    });
  }

  void _generateSelectableTimes() {
    selectableTimes = List.generate(14, (index) {
      return DateFormat.jm().format(DateTime(0, 0, 0, index + 10));
    });
  }

  Future<void> _checkTimeAvailability(String time) async {
    if (selectedDate == null) return;

    // Format the selected date to match Firestore documents
    String formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate!);

    // Query Firestore to check if the selected time is already booked
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('appointments')
        .where('date', isEqualTo: formattedDate)
        .where('time', isEqualTo: time)
        .where('profileUserId',
            isEqualTo: widget.userInfo) // Check for the specific profile
        .get();

    if (snapshot.docs.isNotEmpty) {
      // Time is already booked by another user
      _showTimeAlreadyBookedDialog();
    } else {
      // Proceed to select the time
      setState(() {
        selectedTime = time;
      });
    }
  }

  void _showTimeAlreadyBookedDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Time Already Booked'),
          content: Text(
              'The selected time has already been booked by another user. Please choose a different time.'),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _submitBooking() async {
    if (selectedDate == null || selectedTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Please select both date and time.')));
      return;
    }

    try {
      final userInfo = await getinfo();
      String username = userInfo?['username'] ?? 'Unknown User';
      String address = userInfo?['location'] ?? '';
      List<dynamic> imagesList = userInfo?['images'] ?? [];
      String firstImageUrl = imagesList.isNotEmpty
          ? imagesList[0]
          : ''; // Use the first image or an empty string

      String work = userInfo?['profession'] ?? '';

      await FirebaseFirestore.instance.collection('appointments').add({
        'date': DateFormat('yyyy-MM-dd').format(selectedDate!),
        'time': selectedTime,
        'userId': widget.userId,
        'profileUserId': widget.userInfo,
        'Profileusername': username,
        'work': work,
        'currentname': widget.currentname,
        'address': address,
        'imageUrl': firstImageUrl
      });

      // Reset selections and show success message
      setState(() {
        selectedDate = null;
        selectedTime = null;
      });

      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Appointment booked successfully!')));
    } catch (e) {
      print("Failed to add appointment: $e");
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Failed to book appointment.')));
    }
  }

  Future<Map<String, dynamic>?> getinfo() async {
    DocumentSnapshot userdoc = await FirebaseFirestore.instance
        .collection('user')
        .doc(widget.userInfo)
        .get();
    return userdoc.data() as Map<String, dynamic>;
  }

  Future<void> _checkFavoriteStatus() async {
    final docRef =
        FirebaseFirestore.instance.collection('user').doc(widget.userId);
    final docSnapshot = await docRef.get();

    if (docSnapshot.exists) {
      List<dynamic> favorites = docSnapshot.data()!['favorites'] ?? [];
      setState(() {
        isFavorite = favorites.contains(widget.userInfo);
      });
    }
  }

  Future<void> _toggleFavorite(String favoriteId) async {
    final userId = widget.userId;

    final docRef = FirebaseFirestore.instance.collection('user').doc(userId);

    final docSnapshot = await docRef.get();

    if (docSnapshot.exists) {
      List<dynamic> favorites = docSnapshot.data()!['favorites'] ?? [];

      if (favorites.contains(favoriteId)) {
        favorites.remove(favoriteId);
      } else {
        favorites.add(favoriteId);
      }

      await docRef.update({'favorites': favorites});
      setState(() {
        isFavorite = !isFavorite; // Toggle favorite status
      });
    } else {
      await docRef.set({
        'favorites': [favoriteId]
      });
      setState(() {
        isFavorite = true; // If document doesn't exist, initialize as favorite
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
      future: getinfo(),
      builder: (context, AsyncSnapshot<Map<String, dynamic>?> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text("Error ${snapshot.hasError}"),
          );
        } else if (snapshot.hasData) {
          final info = snapshot.data!;
          String? imageUrl = info['images'] is List && info['images'].isNotEmpty
              ? info['images'][0]
              : null; // Get the first image URL

          return SingleChildScrollView(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromARGB(220, 189, 199, 216), // Left color
                    const Color.fromARGB(214, 255, 255, 255),
                    Colors.white // Right color
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
              ),
              height: 1050,
              width: MediaQuery.of(context).size.width,
              child: Stack(
                children: [
                  Positioned(
                    top: 30,
                    left: 20,
                    right: 20,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            height: 35,
                            width: 35,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Color.fromARGB(255, 179, 191, 212),
                                    width: 0.3),
                                borderRadius: BorderRadius.circular(7),
                                color: Color(0xFFC8D0DE)),
                            child: Center(
                                child: Icon(
                              Icons.arrow_back_rounded,
                              size: 19,
                              color: Color(0xFF7D88A5),
                            )),
                          ),
                        ),
                        InkWell(
                          onTap: () async {
                            await _toggleFavorite(widget
                                .userInfo); // widget.userInfo contains the user ID
                          },
                          child: Container(
                            height: 35,
                            width: 35,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7),
                                color: Color(0xFFFBECEE)),
                            child: Center(
                              child: Icon(
                                isFavorite
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                size: 19,
                                color: isFavorite
                                    ? Color(0xFFFC4848)
                                    : Color(0xFF7D88A5),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Positioned(
                    top: 50,
                    child: SizedBox(
                      height: 190,
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: 110,
                            width: 110,
                            decoration: BoxDecoration(
                                color: Colors.green,
                                image: imageUrl != null
                                    ? DecorationImage(
                                        image: NetworkImage(imageUrl),
                                        fit: BoxFit.cover,
                                      )
                                    : DecorationImage(
                                        image: NetworkImage(
                                            'https://cdn-icons-png.flaticon.com/512/3135/3135715.png'),
                                        fit: BoxFit.cover),
                                borderRadius: BorderRadius.circular(110)),
                          ),
                          Gap(10),
                          Text(
                            info['username'] ?? "",
                            style: GoogleFonts.roboto(
                                fontSize: 15, fontWeight: FontWeight.w400),
                          ),
                          Gap(2),
                          Text(
                            info['profession'] ?? "",
                            style: GoogleFonts.roboto(
                                fontSize: 11, fontWeight: FontWeight.w400),
                          )
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 253,
                    child: Container(
                      height: 150,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: Color(0xFF1B4083),
                          borderRadius: BorderRadius.circular(20)),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            bottom: 50, left: 30, right: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              height: 50,
                              width: 150,
                              child: Stack(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        color: Color(0xFF4A689C),
                                        borderRadius:
                                            BorderRadius.circular(41)),
                                    height: 46,
                                    width: 46,
                                    child: Center(
                                      child: Icon(
                                        Icons.attach_money,
                                        size: 24,
                                        color: Color(0xFFC5CFDF),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                      left: 58,
                                      child: Text(
                                        '\$${info['charge_per_hour'] ?? ""}',
                                        style: GoogleFonts.roboto(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w300,
                                            color: Colors.white),
                                      )),
                                  Positioned(
                                      left: 60,
                                      top: 23,
                                      child: Text(
                                        "Per Hour",
                                        style: GoogleFonts.roboto(
                                            fontSize: 13,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w300),
                                      ))
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 50,
                              width: 150,
                              child: Stack(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        color: Color(0xFF4A689C),
                                        borderRadius:
                                            BorderRadius.circular(41)),
                                    height: 46,
                                    width: 46,
                                    child: Center(
                                      child: Icon(
                                        Icons.military_tech,
                                        size: 24,
                                        color: Color(0xFFC5CFDF),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                      left: 58,
                                      child: Text(
                                        "${info['experience'] ?? ""} Years",
                                        style: GoogleFonts.roboto(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w300,
                                            color: Colors.white),
                                      )),
                                  Positioned(
                                      left: 60,
                                      top: 23,
                                      child: Text(
                                        "Experiences",
                                        style: GoogleFonts.roboto(
                                            fontSize: 13,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w300),
                                      ))
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 350,
                    child: Container(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Color(0xFFBDC7D8), // Left color
                              Colors.white,
                              Colors.white
                            ],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20))),
                      height: 1000,
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 20, top: 25),
                            child: Text(
                              "Shop Address",
                              style: GoogleFonts.roboto(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 20, top: 10, right: 40),
                            child: Text(
                              "${info['location'] ?? ""}",
                              style: GoogleFonts.roboto(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color:
                                      const Color.fromARGB(236, 158, 158, 158)),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20, top: 25),
                            child: Text(
                              "Appointment",
                              style: GoogleFonts.roboto(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20, top: 10),
                            child: SizedBox(
                              height: 90,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: selectableDates.length,
                                itemBuilder: (context, index) {
                                  DateTime date = selectableDates[index];
                                  return GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        selectedDate = date;
                                        selectedTime =
                                            null; // Reset selected time when date is changed
                                      });
                                    },
                                    child: Container(
                                      margin: EdgeInsets.all(6),
                                      height: 40,
                                      width: 48,
                                      decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            color: const Color.fromARGB(
                                                31, 158, 158, 158),
                                            blurRadius: 1,
                                            spreadRadius: 1,
                                          ),
                                        ],
                                        color: selectedDate != null &&
                                                selectedDate!
                                                    .isAtSameMomentAs(date)
                                            ? Color(0xFF1B4083)
                                            : Colors.white,
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          // Abbreviated day of the week
                                          Text(
                                            DateFormat('EEE').format(
                                                date), // Abbreviated day
                                            style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              color: selectedDate != null &&
                                                      selectedDate!
                                                          .isAtSameMomentAs(
                                                              date)
                                                  ? Colors.white
                                                  : Colors.black,
                                              fontSize: 13,
                                            ),
                                          ),
                                          SizedBox(height: 8),
                                          // Date
                                          Text(
                                            DateFormat('d').format(
                                                date), // Day of the month
                                            style: TextStyle(
                                              color: selectedDate != null &&
                                                      selectedDate!
                                                          .isAtSameMomentAs(
                                                              date)
                                                  ? Colors.white
                                                  : Color(0xFFA1A6B6),
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20, top: 16),
                            child: Text(
                              "Scheeduel",
                              style: GoogleFonts.roboto(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20, top: 20),
                            child: SizedBox(
                              height: 25,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: selectableTimes.length,
                                itemBuilder: (context, index) {
                                  String time = selectableTimes[index];
                                  return GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        selectedTime = time;
                                        _checkTimeAvailability(
                                            time); // Check availability on time selection
                                      });
                                    },
                                    child: Container(
                                      width: 105,
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 8),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: const Color.fromARGB(
                                              255, 158, 158, 158),
                                          width: 0.2,
                                        ),
                                        color: selectedTime == time
                                            ? Color(0xFF1B4083)
                                            : Colors.white,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Center(
                                        child: Text(
                                          time,
                                          style: TextStyle(
                                            color: selectedTime == time
                                                ? Colors.white
                                                : Color(0xFFA1A6B6),
                                            fontSize: 10,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 40),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    launchUrlString("tel://${info['number']}");
                                  },
                                  child: Container(
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                      color: Color(0xFFA221D9),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Center(
                                      child: Icon(
                                        Icons.call_outlined,
                                        size: 21,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                    width: 10), // Add space between the buttons
                                Expanded(
                                  child: GestureDetector(
                                    onTap: _submitBooking,
                                    child: Container(
                                      height: 50,
                                      decoration: BoxDecoration(
                                        color: Color(0xFF1B4083),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Center(
                                        child: Text(
                                          "Make an Appointment",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 17,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Gap(30),
                          StarRating(
                            rating: rating,
                            onRatingSelected: (newRating) {
                              setState(() {
                                rating = newRating; // Update the rating value
                              });
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 25, right: 25, top: 20),
                            child: SizedBox(
                              height: 50,
                              width: MediaQuery.of(context).size.width,
                              child: InkWell(
                                onTap: () async {
                                  if (rating > 0) {
                                    await rateUser(widget.userInfo, rating);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text('Rated $rating stars')),
                                    );
                                    setState(() {
                                      rating =
                                          0; // Reset rating after submission
                                    });
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content:
                                              Text('Please select a rating')),
                                    );
                                  }
                                },
                                child: Container(
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: Color(0xFF1B4083),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "Submit Rating",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 17,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        } else {
          return Center(
            child: Text("No data Found"),
          );
        }
      },
    ));
  }

  Future<void> rateUser(String ratedUserId, double rating) async {
    final firestore = FirebaseFirestore.instance;
    String currentUserId = widget.userId;

    // Check if the user has already rated
    final existingRatingSnapshot = await firestore
        .collection('ratings')
        .where('ratedUserId', isEqualTo: ratedUserId)
        .where('userId', isEqualTo: currentUserId)
        .get();

    // If the user has already rated, show the alert dialog and return
    if (existingRatingSnapshot.docs.isNotEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Rating Submission'),
            content: Text('You have already rated this user.'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
      return; // Exit the function to prevent further execution
    }

    // Proceed to add the rating if not already rated
    await firestore.collection('ratings').add({
      'ratedUserId': ratedUserId,
      'userId': currentUserId,
      'rating': rating,
      'timestamp': FieldValue.serverTimestamp(),
    });

    // Calculate the average rating
    await calculateAverageRating(ratedUserId);

    // Show SnackBar only if rating submission is successful
    // ScaffoldMessenger.of(context).showSnackBar(
    //   SnackBar(content: Text('Rated $rating stars')),
    // );
  }

  Future<void> calculateAverageRating(String userId) async {
    final firestore = FirebaseFirestore.instance;

    // Get all ratings for the user
    final snapshot = await firestore
        .collection('ratings')
        .where('ratedUserId', isEqualTo: userId)
        .get();

    if (snapshot.docs.isNotEmpty) {
      double totalRating = 0.0;

      for (var doc in snapshot.docs) {
        totalRating += doc.data()['rating'] as double;
      }

      double averageRating = totalRating / snapshot.docs.length;

      // Update the user's average rating in the user collection
      await firestore.collection('user').doc(userId).set({
        'averageRating': averageRating,
      }, SetOptions(merge: true));
    }
  }
}

class StarRating extends StatelessWidget {
  final double rating;
  final Function(double) onRatingSelected;

  const StarRating(
      {super.key, required this.rating, required this.onRatingSelected});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(5, (index) {
        return IconButton(
          icon: Icon(
            index < rating ? Icons.star : Icons.star_border,
            color: Colors.amber,
          ),
          onPressed: () {
            onRatingSelected(index + 1.0);
          },
        );
      }),
    );
  }
}
