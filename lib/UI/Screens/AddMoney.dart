// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:intl/intl.dart';  // Import the intl package

// class Addmoney extends StatefulWidget {
//   const Addmoney({super.key});

//   @override
//   State<Addmoney> createState() => _AddmoneyState();
// }

// class _AddmoneyState extends State<Addmoney> {
//   final TextEditingController _controller = TextEditingController();

//   // Function to format the entered number with commas (for numbers greater than 1000)
//   String formatAmount(String amount) {
//     if (amount.isEmpty) {
//       return '';
//     }

//     // Remove non-numeric characters for formatting
//     String sanitizedAmount = amount.replaceAll(RegExp(r'[^0-9]'), '');

//     try {
//       final number = int.parse(sanitizedAmount);
//       final formatter = NumberFormat('#,###'); // Format the number with commas
//       return formatter.format(number);
//     } catch (e) {
//       return amount; // In case of an error (e.g., invalid input), return the original string
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       appBar: AppBar(
//         backgroundColor: Colors.black,
//         elevation: 0,
//         leading: IconButton(
//             onPressed: () {
//               Navigator.pop(context);
//             },
//             icon: Icon(
//               Icons.arrow_back_sharp,
//               color: Colors.white,
//               size: 23,
//             )),
//       ),
//       body: Column(
//         children: [
//           // Blue Container Section (Balance & Title)
//           Padding(
//             padding: const EdgeInsets.only(top: 20),
//             child: SizedBox(
//               height: 100,
//               width: MediaQuery.of(context).size.width,
//               child: Stack(
//                 children: [
//                   Positioned(
//                       left: 20,
//                       child: Text(
//                         "Add Money",
//                         style: GoogleFonts.roboto(
//                             color: Colors.white,
//                             fontWeight: FontWeight.w500,
//                             fontSize: 22),
//                       )),
//                   Positioned(
//                       top: 34,
//                       left: 20,
//                       child: Text(
//                         "Available Balance \u{20B9} 7,000",
//                         style: GoogleFonts.roboto(
//                             color: Colors.white,
//                             fontWeight: FontWeight.w500,
//                             fontSize: 14),
//                       )),
//                   Positioned(
//                     top: 1,
//                     right: 20,
//                     child: Container(
//                       height: 50,
//                       width: 50,
//                       decoration: BoxDecoration(
//                           color: Colors.green,
//                           borderRadius: BorderRadius.circular(51)),
//                     ),
//                   )
//                 ],
//               ),
//             ),
//           ),
//           // TextField for Amount Entry
//           Padding(
//             padding: const EdgeInsets.only(left: 20, right: 20, top: 35),
//             child: Container(
//               height: 65,
//               decoration: BoxDecoration(
//                   color: Color(0xFF1F2125),
//                   borderRadius: BorderRadius.circular(5)),
//               width: MediaQuery.of(context).size.width,
//               child: Center(
//                 child: Padding(
//                   padding: const EdgeInsets.only(left: 10),
//                   child: TextField(
//                     readOnly: true,
//                     controller: _controller,
//                     cursorHeight: 20,
//                     style: TextStyle(
//                         color: const Color.fromARGB(106, 255, 255, 255),
//                         fontSize: 21,
//                         fontWeight: FontWeight.w500),
//                     cursorColor: Colors.blue,
//                     decoration: InputDecoration(
//                       hintText: "Amount",
//                       hintStyle: TextStyle(
//                           fontSize: 20,
//                           fontWeight: FontWeight.w500,
//                           color: const Color.fromARGB(106, 255, 255, 255)),
//                       prefixText: '\u{20B9} ',
//                       prefixStyle:
//                           TextStyle(color: Colors.white, fontSize: 20),
//                       border: InputBorder.none,
//                     ),
//                     onChanged: (value) {
//                       // Save the current cursor position
//                       final textLength = value.length;
//                       final cursorPos = _controller.selection.baseOffset;

//                       // Format the value
//                       String formattedValue = formatAmount(value);

//                       // Update the text and maintain the cursor position
//                       setState(() {
//                         _controller.value = TextEditingValue(
//                           text: formattedValue,
//                           selection: TextSelection.collapsed(
//                               offset: cursorPos != -1
//                                   ? cursorPos
//                                   : formattedValue.length), // Keep the cursor at the same position or at the end
//                         );
//                       });
//                     },
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           // Proceed Button
//           Padding(
//             padding: const EdgeInsets.only(left: 20, right: 20, top: 25),
//             child: Container(
//               height: 50,
//               width: MediaQuery.of(context).size.width,
//               decoration: BoxDecoration(
//                   color: Color(0xFF2A7AF1),
//                   borderRadius: BorderRadius.circular(8)),
//               child: Center(
//                 child: Text(
//                   "Proceed to Add Money",
//                   style: TextStyle(
//                       color: Colors.white,
//                       fontWeight: FontWeight.w500,
//                       fontSize: 15),
//                 ),
//               ),
//             ),
//           ),
          
//           // The keyboard will be flushed to the bottom without any extra space
//           Expanded(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 // First Row (1 2 3)
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     buildKey('1', ''),
//                     buildKey('2', 'ABC'),
//                     buildKey('3', 'DEF'),
//                   ],
//                 ),
//                 // Second Row (4 5 6)
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     buildKey('4', 'GHI'),
//                     buildKey('5', 'JKL'),
//                     buildKey('6', 'MNO'),
//                   ],
//                 ),
//                 // Third Row (7 8 9)
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     buildKey('7', 'PQRS'),
//                     buildKey('8', 'TUV'),
//                     buildKey('9', 'WXYZ'),
//                   ],
//                 ),
//                 // Fourth Row (0 and Cancel)
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     // Empty container for spacing before the 0 key
//                     Container(
//                       width: 100, // Adjust as needed
//                     ),
//                     // The 0 key in the center
//                     Center(child: buildKey('0', '')),
//                     // Container with Cancel button on the right side
//                     SizedBox(
//                       width: 100, // Adjust as needed
//                       child: Center(
//                         child: IconButton(
//                           onPressed: () {
//                             // Handle cancel functionality (remove last character)
//                             if (_controller.text.isNotEmpty) {
//                               String updatedText = _controller.text.substring(0, _controller.text.length - 1);
//                               // Preserve the cursor position after removing text
//                               setState(() {
//                                 _controller.value = TextEditingValue(
//                                   text: formatAmount(updatedText),
//                                   selection: TextSelection.collapsed(offset: updatedText.length), // Keep the cursor at the end
//                                 );
//                               });
//                             }
//                           },
//                           icon: Icon(Icons.arrow_back_ios_new_rounded, size: 27, color: Colors.white),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // Helper method to create the keyboard keys
//   Widget buildKey(String number, String label) {
//     return GestureDetector(
//       onTap: () {
//         // When a key is pressed, append it to the current text in the TextField
//         setState(() {
//           _controller.text += number;
//           _controller.text = formatAmount(_controller.text); // Format as user types
//           _controller.selection = TextSelection.fromPosition(TextPosition(offset: _controller.text.length)); // Keep the cursor at the end
//         });
//       },
//       child: Container(
//         margin: EdgeInsets.all(8),
//         height: 50, // Set height as per your requirement
//         width: 100, // Set width as per your requirement
//         decoration: BoxDecoration(
//           color: Color(0xFF444444),
//           borderRadius: BorderRadius.circular(7),
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               number,
//               style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w500),
//             ),
//             Text(
//               label,
//               style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w500),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }




import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';  // Import the intl package
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Addmoney extends StatefulWidget {
  const Addmoney({super.key});

  @override
  State<Addmoney> createState() => _AddmoneyState();
}

class _AddmoneyState extends State<Addmoney> {
  final TextEditingController _controller = TextEditingController();

  // Function to format the entered number with commas (for numbers greater than 1000)
  String formatAmount(String amount) {
    if (amount.isEmpty) {
      return '';
    }

    // Remove non-numeric characters for formatting
    String sanitizedAmount = amount.replaceAll(RegExp(r'[^0-9]'), '');

    try {
      final number = int.parse(sanitizedAmount);
      final formatter = NumberFormat('#,###'); // Format the number with commas
      return formatter.format(number);
    } catch (e) {
      return amount; // In case of an error (e.g., invalid input), return the original string
    }
  }

  // Method to handle sending data to Firestore
  void addMoneyToUser() async {
    // Get the current user
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      String enteredAmount = _controller.text.replaceAll(RegExp(r'[^0-9]'), ''); // Remove any non-numeric characters

      if (enteredAmount.isNotEmpty) {
        // Convert the amount to an integer
        int amount = int.parse(enteredAmount);

        // Reference to the user's document
        DocumentReference userDoc = FirebaseFirestore.instance.collection('user').doc(user.uid);

        // Update the user's balance (or any other relevant data field)
        await userDoc.update({
          'balance': FieldValue.increment(amount), // Increment the balance by the entered amount
        }).then((_) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Money added successfully!")),
          );
        }).catchError((error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Error: $error")),
          );
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Please enter a valid amount")),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("No user is logged in")),
      );
    }
  }
  String balance = '0';  // Default balance is '0'

  @override
  void initState() {
    super.initState();
    _fetchBalance();  // Fetch the balance when the screen is initialized
  }

  // Fetch current balance from Firestore
  Future<void> _fetchBalance() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      try {
        // Fetch the user's document from Firestore
        DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('user').doc(user.uid).get();

        if (userDoc.exists) {
          // Get the balance from the document (assuming it's stored as 'balance')
          var userBalance = userDoc['balance'];
          setState(() {
            balance = userBalance != null ? userBalance.toString() : '0';
          });
        }
      } catch (e) {
        // Handle any errors that occur during fetching
        print("Error fetching balance: $e");
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_sharp,
            color: Colors.white,
            size: 23,
          ),
        ),
      ),
      body: Column(
        children: [
          // Blue Container Section (Balance & Title)
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: SizedBox(
              height: 100,
              width: MediaQuery.of(context).size.width,
              child: Stack(
                children: [
                  Positioned(
                    left: 20,
                    child: Text(
                      "Add Money",
                      style: GoogleFonts.roboto(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 22),
                    ),
                  ),
                  Positioned(
                    top: 34,
                    left: 20,
                    child: Text(
                      "Available Balance \u{20B9} $balance",
                      style: GoogleFonts.roboto(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 14),
                    ),
                  ),
                  Positioned(
                    top: 1,
                    right: 20,
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(51)),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // TextField for Amount Entry
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 35),
            child: Container(
              height: 65,
              decoration: BoxDecoration(
                  color: Color(0xFF1F2125),
                  borderRadius: BorderRadius.circular(5)),
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: TextField(
                    readOnly: true,
                    controller: _controller,
                    cursorHeight: 20,
                    style: TextStyle(
                        color: const Color.fromARGB(106, 255, 255, 255),
                        fontSize: 21,
                        fontWeight: FontWeight.w500),
                    cursorColor: Colors.blue,
                    decoration: InputDecoration(
                      hintText: "Amount",
                      hintStyle: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: const Color.fromARGB(106, 255, 255, 255)),
                      prefixText: '\u{20B9} ',
                      prefixStyle:
                          TextStyle(color: Colors.white, fontSize: 20),
                      border: InputBorder.none,
                    ),
                    onChanged: (value) {
                      // Save the current cursor position
                      final textLength = value.length;
                      final cursorPos = _controller.selection.baseOffset;

                      // Format the value
                      String formattedValue = formatAmount(value);

                      // Update the text and maintain the cursor position
                      setState(() {
                        _controller.value = TextEditingValue(
                          text: formattedValue,
                          selection: TextSelection.collapsed(
                              offset: cursorPos != -1
                                  ? cursorPos
                                  : formattedValue.length), // Keep the cursor at the same position or at the end
                        );
                      });
                    },
                  ),
                ),
              ),
            ),
          ),
          // Proceed Button
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 25),
            child: GestureDetector(
              onTap: addMoneyToUser,  // Trigger the addMoneyToUser method
              child: Container(
                height: 50,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Color(0xFF2A7AF1),
                    borderRadius: BorderRadius.circular(8)),
                child: Center(
                  child: Text(
                    "Proceed to Add Money",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 15),
                  ),
                ),
              ),
            ),
          ),
          
          // The keyboard will be flushed to the bottom without any extra space
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // First Row (1 2 3)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    buildKey('1', ''),
                    buildKey('2', 'ABC'),
                    buildKey('3', 'DEF'),
                  ],
                ),
                // Second Row (4 5 6)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    buildKey('4', 'GHI'),
                    buildKey('5', 'JKL'),
                    buildKey('6', 'MNO'),
                  ],
                ),
                // Third Row (7 8 9)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    buildKey('7', 'PQRS'),
                    buildKey('8', 'TUV'),
                    buildKey('9', 'WXYZ'),
                  ],
                ),
                // Fourth Row (0 and Cancel)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Empty container for spacing before the 0 key
                    Container(
                      width: 100, // Adjust as needed
                    ),
                    // The 0 key in the center
                    Center(child: buildKey('0', '')),
                    // Container with Cancel button on the right side
                    SizedBox(
                      width: 100, // Adjust as needed
                      child: Center(
                        child: IconButton(
                          onPressed: () {
                            // Handle cancel functionality (remove last character)
                            if (_controller.text.isNotEmpty) {
                              String updatedText = _controller.text.substring(0, _controller.text.length - 1);
                              // Preserve the cursor position after removing text
                              setState(() {
                                _controller.value = TextEditingValue(
                                  text: formatAmount(updatedText),
                                  selection: TextSelection.collapsed(offset: updatedText.length), // Keep the cursor at the end
                                );
                              });
                            }
                          },
                          icon: Icon(Icons.arrow_back_ios_new_rounded, size: 27, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Helper method to create the keyboard keys
  Widget buildKey(String number, String label) {
    return GestureDetector(
      onTap: () {
        // When a key is pressed, append it to the current text in the TextField
        setState(() {
          _controller.text += number;
          _controller.text = formatAmount(_controller.text); // Format as user types
          _controller.selection = TextSelection.fromPosition(TextPosition(offset: _controller.text.length)); // Keep the cursor at the end
        });
      },
      child: Container(
        margin: EdgeInsets.all(8),
        height: 50, // Set height as per your requirement
        width: 100, // Set width as per your requirement
        decoration: BoxDecoration(
          color: Color(0xFF444444),
          borderRadius: BorderRadius.circular(7),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              number,
              style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w500),
            ),
            Text(
              label,
              style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}

