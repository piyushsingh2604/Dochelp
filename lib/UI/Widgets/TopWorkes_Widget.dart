import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class TopworkesWidget extends StatelessWidget {
  String currentname;
  String userId;
  TopworkesWidget({super.key, required this.userId, required this.currentname});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('user').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text("Error ${snapshot.error}"),
            );
          } else if (snapshot.hasData) {
            final docs = snapshot.data!.docs;
            // Filter out users with an empty profession
            final filteredDocs = docs.where((doc) {
              var data = doc.data();
              return data['profession'] != null &&
                  data['profession'].isNotEmpty;
            }).toList();

            return ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              itemCount: filteredDocs.length,
              itemBuilder: (context, index) {
                var data = filteredDocs[index].data();
                final users = docs[index];
                var useruid = filteredDocs[index].id;   var chargePerHour = data['charge_per_hour'];  // Worker charge per hour

// Log charge_per_hour to check the value
print("Charge per Hour for worker ${data['username']}: $chargePerHour");

// Convert charge_per_hour to a string explicitly
if (chargePerHour == null || chargePerHour == 0) {
  chargePerHour = "0";  // Default to "0" if null or zero
} else {
  chargePerHour = chargePerHour.toString();  // Convert int to string
}
                return Padding(
                  padding: const EdgeInsets.only(top: 6),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AboutScree(chargePerHour:chargePerHour ,
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
                                        : NetworkImage(data['images'] ??
                                            'https://cdn-icons-png.flaticon.com/512/3135/3135715.png'),
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





class AboutScree extends StatefulWidget {
  final String currentname;
  final String userId;      // Current user's ID (client)
  final String userInfo;    // Worker user's UID
  final String chargePerHour;

  AboutScree({
    super.key,
    required this.currentname,
    required this.userId,
    required this.userInfo,
    required this.chargePerHour,
  });

  @override
  _AboutScreeState createState() => _AboutScreeState();
}

class _AboutScreeState extends State<AboutScree> {
  String currentUserBalance = '0';  // Only show this, since you don't want to show worker's balance anymore.

  @override
  void initState() {
    super.initState();
    _fetchBalance();  // Fetch the current user’s balance.
  }

  Future<void> _fetchBalance() async {
    try {
      // Fetch the current user's balance using their UID (widget.userId)
      DocumentSnapshot currentUserDoc = await FirebaseFirestore.instance
          .collection('user')
          .doc(widget.userId)  // Use the userId passed from TopworkersWidget
          .get();

      // Check if the document exists and get the balance
      if (currentUserDoc.exists) {
        print("Current User Document: ${currentUserDoc.data()}");
        var currentUserBalanceValue = currentUserDoc['balance'];

        if (currentUserBalanceValue == null) {
          print("Balance field is missing for current user.");
          currentUserBalanceValue = 0;
        }

        setState(() {
          currentUserBalance = currentUserBalanceValue.toString();
        });
      } else {
        print("Document for current user does not exist.");
        setState(() {
          currentUserBalance = '0';
        });
      }

      // You no longer need to fetch or store the worker’s balance, so we skip that part.

    } catch (e) {
      print("Error fetching balance: $e");
    }
  }
Future<void> _processTransaction() async {
  // Get the charge per hour for the worker (you already have this from the widget)
  int chargeAmount = int.parse(widget.chargePerHour); 
  // Get the current balance of the current user (client)
  int currentBalance = int.parse(currentUserBalance); 

  // Check if the current user (client) has enough balance
  if (currentBalance >= chargeAmount) {
    // Deduct the charge amount from the current user's balance
    int newCurrentUserBalance = currentBalance - chargeAmount;

    try {
      // Update the current user's balance in Firestore
      await FirebaseFirestore.instance.collection('user').doc(widget.userId).update({
        'balance': newCurrentUserBalance, // Decrease balance of the current user
      });

      // Update the worker's balance in Firestore
      await FirebaseFirestore.instance.collection('user').doc(widget.userInfo).update({
        'balance': FieldValue.increment(chargeAmount), // Increase balance of the worker
      });

      // Show a success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Transaction successful!")),
      );

      // Update the local state to reflect the changes
      setState(() {
        currentUserBalance = newCurrentUserBalance.toString();
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    }
  } else {
    // If the current user doesn't have enough balance, show an error message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Insufficient balance")),
    );
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('About User')),
      body: Column(
        children: [
          Text('Current User Balance: \$${currentUserBalance}'),
          Text('Worker Charge Per Hour: \$${widget.chargePerHour}'),  // Only display the charge per hour for the worker.
          ElevatedButton(
            onPressed: _processTransaction,
            child: Text('Deduct and Add Money'),
          ),
        ],
      ),
    );
  }
}
