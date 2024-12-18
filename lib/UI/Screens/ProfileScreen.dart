import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dochelp/UI/Screens/AddMoney.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class Profilescreen extends StatefulWidget {
  const Profilescreen({super.key});

  @override
  State<Profilescreen> createState() => _ProfilescreenState();
}

class _ProfilescreenState extends State<Profilescreen> {
  final currentuser = FirebaseAuth.instance;

  TextEditingController nameController = TextEditingController();

  TextEditingController addressController = TextEditingController();

  TextEditingController _controller = TextEditingController();

  bool text1 = false;

  bool text2 = false;

  List<String> states = [
    "Andhra Pradesh",
    "Arunachal Pradesh",
    "Assam",
    "Bihar",
    "Chhattisgarh",
    "Goa",
    "Gujarat",
    "Haryana",
    "Himachal Pradesh",
    "Jharkhand",
    "Karnataka",
    "Kerala",
    "Madhya Pradesh",
    "Maharashtra",
    "Manipur",
    "Meghalaya",
    "Mizoram",
    "Nagaland",
    "Odisha",
    "Punjab",
    "Rajasthan",
    "Sikkim",
    "Tamil Nadu",
    "Telangana",
    "Tripura",
    "Uttar Pradesh",
    "Uttarakhand",
    "West Bengal",
  ];
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> updateName() async {
    final user = auth.currentUser;
    if (user != null) {
      await FirebaseFirestore.instance.collection('user').doc(user.uid).update({
        'name': nameController.text,
      });
    }
  }

  Future<void> updateAddress() async {
    final user = currentuser.currentUser;
    if (user != null) {
      await FirebaseFirestore.instance.collection('user').doc(user.uid).update({
        'address': _controller.text,
      });
    }
  }

// image function
  File? _image;

 Future<void> _pickImage() async {
  final ImagePicker picker = ImagePicker();
  final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);

  if (pickedFile != null) {
    print('Picked image: ${pickedFile.path}');
    User? user = FirebaseAuth.instance.currentUser;
    String? oldImageUrl;

    // Fetch the old image URL from Firestore
    if (user != null) {
      DocumentSnapshot doc = await FirebaseFirestore.instance.collection('user').doc(user.uid).get();
      var data = doc.data() as Map<String, dynamic>?;

      if (data != null && data['images'] is List && data['images'].isNotEmpty) {
        oldImageUrl = data['images'][0]; // Get the old image URL
      }
    }

    setState(() {
      _image = File(pickedFile.path);
    });

    await _uploadImage(_image!, oldImageUrl);
  } else {
    print('No image selected');
  }
}

 Future<void> _uploadImage(File image, String? oldImageUrl) async {
  try {
    // Delete the old image from Firebase Storage
    if (oldImageUrl != null && oldImageUrl.isNotEmpty) {
      Reference oldImageRef = FirebaseStorage.instance.refFromURL(oldImageUrl);
      await oldImageRef.delete();
      print('Deleted old image: $oldImageUrl');
    }

    // Upload the new image
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    Reference storageRef = FirebaseStorage.instance.ref().child('uploads/$fileName');
    UploadTask uploadTask = storageRef.putFile(image);

    // Await the upload completion and get the download URL
    String downloadURL = await (await uploadTask).ref.getDownloadURL();
    print('Uploaded new image: $downloadURL');

    // Get the current user
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      // Update the user's document with the new image URL
      await FirebaseFirestore.instance.collection('user').doc(user.uid).update({
        'images': [downloadURL], // Store only the new image URL
        'updated_at': Timestamp.now(),
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Uploaded! URL: $downloadURL')),
      );
    }
  } catch (e) {
    print('Upload failed: $e');
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
        backgroundColor: Color(0xFFF7F8F9),
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
            } else if (!snapshot.hasData || snapshot.data?.docs == null) {
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
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 15),
                          child: SizedBox(
                            height: 55,
                            child: Stack(
                              children: [
                                Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    "Profile",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 19,
                                    ),
                                  ),
                                ),
                                 Positioned(
                                  right: 15,
                                   child: InkWell(
                                           onTap: () {
                                             Navigator.push(
                                                 context,
                                                 MaterialPageRoute(
                                                   builder: (context) => Addmoney(),
                                                 ));
                                           },
                                           child: Container(
                                             height: 44,
                                             width: 110,
                                             decoration: BoxDecoration(
                                                 boxShadow: [
                                                   BoxShadow(
                                                       color: const Color.fromARGB(40, 158, 158, 158),
                                                       spreadRadius: 3,
                                                       blurRadius: 2)
                                                 ],
                                                 color: Colors.white,
                                                 borderRadius: BorderRadius.circular(30)),
                                             child: Stack(
                                               children: [
                                                 Positioned(
                                                     top: 2,
                                                     left: 15,
                                                     child: Text(
                                                       '\u{20B9}',
                                                       style: TextStyle(
                                                           color: Colors.black54,
                                                           fontSize: 30,
                                                           fontWeight: FontWeight.w500),
                                                     )),
                                                 Positioned(
                                                     top: 5,
                                                     left: 40,
                                                     child: Text(
                                                       "Balance",
                                                       style: TextStyle(
                                                           color: Colors.black,
                                                           fontWeight: FontWeight.w500,
                                                           fontSize: 10),
                                                     )),
                                                 Positioned(
                                                     left: 39.4,
                                                     top: 16.7,
                                                     child: Text(
                                                       balance,
                                                       style: TextStyle(
                                                           color: Colors.black54,
                                                           fontWeight: FontWeight.w500,
                                                           fontSize: 14),
                                                     ))
                                               ],
                                             ),
                                           ),
                                         ),
                                 ),
                              ],
                            ),
                          ),
                        ),
                        Gap(15),
                        SizedBox(
                          height: 100,
                          width: 110,
                          child: Stack(
                            children: [
                              Container(
                                height: 100,
                                width: 100,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image:
                                           NetworkImage(
              (data['images'] is List && data['images'].isNotEmpty)
                  ? data['images'][0]
                  : '',
            ),
            fit: BoxFit.cover, 
                                            
                                            ),
                                    borderRadius: BorderRadius.circular(100),
                                    border: Border.all(
                                        color: Color(0xFFEDBC52), width: 1.9)),
                              ),
                              Positioned(
                                left: 85,
                                bottom: 17,
                                child: InkWell(
                                  onTap: _pickImage,
                                  child: Container(
                                    height: 16,
                                    width: 16,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Color(0xFFEDBC52), width: 1),
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Icon(
                                      Icons.camera_alt_outlined,
                                      color: Colors.black,
                                      size: 9, // Icon size
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Gap(10),
                        Text(
                          data['username'] ?? "",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 19,
                              fontWeight: FontWeight.w500),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 20),
                          child: Container(
                            height: 40,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8)),
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, right: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: 200,
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.person_outline_outlined,
                                          color: const Color.fromARGB(
                                              117, 0, 0, 0),
                                          size: 22,
                                        ),
                                        Gap(5),
                                        Text(
                                          data['name'] ?? "Update your userName",
                                          style: TextStyle(
                                              color: const Color.fromARGB(
                                                  117, 0, 0, 0),
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500),
                                        )
                                      ],
                                    ),
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        showModalBottomSheet(
                                          context: context,
                                          builder: (context) {
                                            return Container(
                                              decoration: BoxDecoration(
                                                  color: Color(0xFFF4F4F4),
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  30),
                                                          topRight:
                                                              Radius.circular(
                                                                  30))),
                                              height: 700,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 11, top: 20),
                                                    child: IconButton(
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        icon: Icon(
                                                          Icons
                                                              .arrow_back_ios_new_rounded,
                                                          color: Colors.black,
                                                          size: 20,
                                                        )),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 20,
                                                            right: 20,
                                                            top: 20),
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          color: const Color
                                                              .fromARGB(223,
                                                              255, 255, 255)),
                                                      height: 45,
                                                      width:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                left: 20,
                                                                bottom: 16),
                                                        child: SizedBox(
                                                          width: 200,
                                                          child: TextField(
                                                            controller:
                                                                nameController,
                                                            cursorHeight: 16,
                                                            decoration:
                                                                InputDecoration(
                                                              hintText:
                                                                  'Enter your name',
                                                              hintStyle: GoogleFonts.poppins(
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w300),
                                                              border:
                                                                  InputBorder
                                                                      .none,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Visibility(
                                                    visible: text1,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 20,
                                                              top: 10),
                                                      child: Text(
                                                        "Please enter your name",
                                                        style: TextStyle(
                                                            fontSize: 11,
                                                            color: const Color
                                                                .fromARGB(
                                                                110, 0, 0, 0)),
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 20,
                                                            right: 20,
                                                            top: 30),
                                                    child: InkWell(
                                                      onTap: () {
                                                        var value =
                                                            nameController.text;
                                                        if (value.isEmpty) {
                                                          setState(() {
                                                            text1 = !text1;
                                                          });
                                                        } else {
                                                          updateName();
                                                          Navigator.pop(
                                                              context);
                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .showSnackBar(SnackBar(
                                                                  content: Text(
                                                                      "Your name is updated")));
                                                        }
                                                      },
                                                      child: Container(
                                                        height: 42,
                                                        width: MediaQuery.of(
                                                                context)
                                                            .size
                                                            .width,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          color:
                                                              Color(0xFF2C41FF),
                                                        ),
                                                        child: Center(
                                                          child: Text(
                                                            "UPDATE",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontSize: 16),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                        );
                                      },
                                      icon: Icon(
                                        Icons.edit_square,
                                        size: 18,
                                        color:
                                            const Color.fromARGB(117, 0, 0, 0),
                                      ))
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 15),
                          child: Container(
                            height: 40,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8)),
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, right: 10),
                              child: SizedBox(
                                width: 250,
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.email_outlined,
                                      color: const Color.fromARGB(117, 0, 0, 0),
                                      size: 23,
                                    ),
                                    Gap(5),
                                    Text(
                                      data['email'] ?? "",
                                      style: TextStyle(
                                          color: const Color.fromARGB(
                                              117, 0, 0, 0),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 15),
                          child: Container(
                            height: 40,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8)),
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, right: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: 250,
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.location_on_outlined,
                                          color: const Color.fromARGB(
                                              117, 0, 0, 0),
                                          size: 23,
                                        ),
                                        Gap(5),
                                        Text(
                                          data['address'] ?? 'Enter your state',
                                          style: TextStyle(
                                              color: const Color.fromARGB(
                                                  117, 0, 0, 0),
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500),
                                        )
                                      ],
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      showModalBottomSheet(
                                        isScrollControlled: true,
                                        context: context,
                                        builder: (context) {
                                          return Container(
                                            decoration: BoxDecoration(
                                              color: Color(0xFFF4F4F4),
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(0),
                                                topRight: Radius.circular(0),
                                              ),
                                            ),
                                            height: 900,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 11, top: 20),
                                                  child: IconButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    icon: Icon(
                                                      Icons
                                                          .arrow_back_ios_new_rounded,
                                                      color: Colors.black,
                                                      size: 20,
                                                    ),
                                                  ),
                                                ),
                                                Gap(30),
                                                Autocomplete<String>(
                                                  optionsBuilder:
                                                      (TextEditingValue
                                                          textEditingValue) {
                                                    if (textEditingValue
                                                        .text.isEmpty) {
                                                      return const Iterable<
                                                          String>.empty();
                                                    }
                                                    return states
                                                        .where((String state) {
                                                      return state
                                                          .toLowerCase()
                                                          .contains(
                                                              textEditingValue
                                                                  .text
                                                                  .toLowerCase());
                                                    });
                                                  },
                                                  onSelected:
                                                      (String selectedState) {
                                                    // Update the TextEditingController with the selected state
                                                    _controller.text =
                                                        selectedState;
                                                  },
                                                  fieldViewBuilder: (context,
                                                      textEditingController,
                                                      focusNode,
                                                      onFieldSubmitted) {
                                                    _controller =
                                                        textEditingController; // Use the passed textEditingController
                                                    return Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 20,
                                                              right: 20,
                                                              top: 20),
                                                      child: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          color: const Color
                                                              .fromARGB(223,
                                                              255, 255, 255),
                                                        ),
                                                        height: 45,
                                                        width: MediaQuery.of(
                                                                context)
                                                            .size
                                                            .width,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  left: 20,
                                                                  bottom: 16),
                                                          child: TextField(
                                                            focusNode:
                                                                focusNode,
                                                            controller:
                                                                textEditingController, // Pass the controller here
                                                            cursorHeight: 16,
                                                            decoration:
                                                                InputDecoration(
                                                              hintText:
                                                                  'Enter your State',
                                                              hintStyle: GoogleFonts.poppins(
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w300),
                                                              border:
                                                                  InputBorder
                                                                      .none,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 20,
                                                          right: 20,
                                                          top: 30),
                                                  child: InkWell(
                                                    onTap: () {
                                                      var value =
                                                          _controller.text;
                                                      if (value.isEmpty) {
                                                        print(
                                                            "Error: State is empty");
                                                      } else {
                                                        updateAddress(); // Ensure this updates the Firestore document
                                                        Navigator.pop(context);
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(SnackBar(
                                                                content: Text(
                                                                    "Your State is updated")));
                                                      }
                                                    },
                                                    child: Container(
                                                      height: 42,
                                                      width:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        color:
                                                            Color(0xFF2C41FF),
                                                      ),
                                                      child: Center(
                                                        child: Text(
                                                          "UPDATE",
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontSize: 16,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      );
                                    },
                                    icon: Icon(
                                      Icons.edit_square,
                                      size: 18,
                                      color: const Color.fromARGB(117, 0, 0, 0),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 15),
                          child: Container(
                            height: 40,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8)),
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, right: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: 250,
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.support_agent_outlined,
                                          color: const Color.fromARGB(
                                              117, 0, 0, 0),
                                          size: 23,
                                        ),
                                        Gap(5),
                                        Text(
                                          "Support",
                                          style: TextStyle(
                                              color: const Color.fromARGB(
                                                  117, 0, 0, 0),
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500),
                                        )
                                      ],
                                    ),
                                  ),
                                  IconButton(
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.arrow_forward_ios_sharp,
                                        size: 18,
                                        color:
                                            const Color.fromARGB(117, 0, 0, 0),
                                      ))
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 15),
                          child: Container(
                            height: 40,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8)),
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, right: 10),
                              child: SizedBox(
                                width: 250,
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.logout_rounded,
                                      color: const Color.fromARGB(117, 0, 0, 0),
                                      size: 23,
                                    ),
                                    Gap(5),
                                    Text(
                                      "Log Out",
                                      style: TextStyle(
                                          color: const Color.fromARGB(
                                              117, 0, 0, 0),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500),
                                    )
                                  ],
                                ),
                              ),
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
                child: Text("no data found"),
              );
            }
          },
        ));
  }
}
