import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class Profilescreen extends StatefulWidget {
  const Profilescreen({super.key});

  @override
  State<Profilescreen> createState() => _ProfilescreenState();
}

class _ProfilescreenState extends State<Profilescreen> {
  TextEditingController name = TextEditingController();
  TextEditingController address = TextEditingController();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF7F8F9),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 35),
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: InkWell(
                      onTap: () {},
                      child: Container(
                        height: 25,
                        width: 25,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Icon(
                          Icons.arrow_back_outlined,
                          color: Colors.black,
                          size: 19,
                        ),
                      ),
                    ),
                  ),
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
                ],
              ),
            ),
            Gap(20),
            Container(
              height: 100,
              width: 110,
              child: Stack(
                children: [
                  Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(100),
                        border:
                            Border.all(color: Color(0xFFEDBC52), width: 1.9)),
                  ),
                  Positioned(
                    left: 85,
                    bottom: 17,
                    child: InkWell(
                      onTap: () {},
                      child: Container(
                        height: 16,
                        width: 16,
                        decoration: BoxDecoration(
                          border:
                              Border.all(color: Color(0xFFEDBC52), width: 1),
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Icon(
                          Icons.edit_outlined,
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
              "Satyam Panday",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 19,
                  fontWeight: FontWeight.w500),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
              child: Container(
                height: 40,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8)),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 200,
                        child: Row(
                          children: [
                            Icon(
                              Icons.person_outline_outlined,
                              color: const Color.fromARGB(117, 0, 0, 0),
                              size: 22,
                            ),
                            Gap(5),
                            Text(
                              "Satyam Pandey",
                              style: TextStyle(
                                  color: const Color.fromARGB(117, 0, 0, 0),
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
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(30),
                                          topRight: Radius.circular(30))),
                                  height: 700,
                                  width: MediaQuery.of(context).size.width,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 11, top: 20),
                                        child: IconButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            icon: Icon(
                                              Icons.arrow_back_ios_new_rounded,
                                              color: Colors.black,
                                              size: 20,
                                            )),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 20, right: 20, top: 20),
                                        child: Container(
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 20, bottom: 16),
                                            child: Container(
                                              width: 200,
                                              child: TextField(
                                                controller: name,
                                                cursorHeight: 16,
                                                decoration: InputDecoration(
                                                  hintText: 'Enter your name',
                                                  hintStyle:
                                                      GoogleFonts.poppins(
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w300),
                                                  border: InputBorder.none,
                                                ),
                                              ),
                                            ),
                                          ),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: const Color.fromARGB(
                                                  223, 255, 255, 255)),
                                          height: 45,
                                          width:
                                              MediaQuery.of(context).size.width,
                                        ),
                                      ),
                                      Visibility(
                                        visible: text1,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 20, top: 10),
                                          child: Text(
                                            "Please enter your name",
                                            style: TextStyle(
                                                fontSize: 11,
                                                color: const Color.fromARGB(
                                                    110, 0, 0, 0)),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 20, right: 20, top: 30),
                                        child: InkWell(
                                          onTap: () {
                                            var value = name.text;
                                            if (value.isEmpty) {
                                              setState(() {
                                                text1 = !text1;
                                              });
                                            } else {
                                              Navigator.pop(context);
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(SnackBar(
                                                      content: Text(
                                                          "Your name is updated")));
                                            }
                                          },
                                          child: Container(
                                            child: Center(
                                              child: Text(
                                                "UPDATE",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 16),
                                              ),
                                            ),
                                            height: 42,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: Color(0xFF2C41FF),
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
                          ))
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 15),
              child: Container(
                height: 40,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8)),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Container(
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
                          "satyampandey@gmail.com",
                          style: TextStyle(
                              color: const Color.fromARGB(117, 0, 0, 0),
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
              padding: const EdgeInsets.only(left: 20, right: 20, top: 15),
              child: Container(
                height: 40,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8)),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 250,
                        child: Row(
                          children: [
                            Icon(
                              Icons.location_on_outlined,
                              color: const Color.fromARGB(117, 0, 0, 0),
                              size: 23,
                            ),
                            Gap(5),
                            Text(
                              "Mumbai, Maharashtra",
                              style: TextStyle(
                                  color: const Color.fromARGB(117, 0, 0, 0),
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
                                          topRight: Radius.circular(0))),
                                  height: 900,
                                  width: MediaQuery.of(context).size.width,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 11, top: 20),
                                        child: IconButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            icon: Icon(
                                              Icons.arrow_back_ios_new_rounded,
                                              color: Colors.black,
                                              size: 20,
                                            )),
                                      ),
                                      Gap(30),
                                      Autocomplete<String>(
                                        optionsBuilder: (TextEditingValue
                                            textEditingValue) {
                                          if (textEditingValue.text.isEmpty) {
                                            return const Iterable<
                                                String>.empty();
                                          }
                                          return states.where((String state) {
                                            return state.toLowerCase().contains(
                                                textEditingValue.text
                                                    .toLowerCase());
                                          });
                                        },
                                        onSelected: (String selectedState) {
                                          _controller.text = selectedState;
                                        },
                                        fieldViewBuilder: (context,
                                            textEditingController,
                                            focusNode,
                                            onFieldSubmitted) {
                                          _controller = textEditingController;
                                          return Padding(
                                            padding: const EdgeInsets.only(
                                                left: 20, right: 20, top: 20),
                                            child: Container(
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 20, bottom: 16),
                                                child: Container(
                                                  width: 200,
                                                  child: TextField(                  focusNode: focusNode,

                                                    controller: textEditingController,
                                                    cursorHeight: 16,
                                                    decoration: InputDecoration(
                                                      hintText:
                                                          'Enter your State',
                                                      hintStyle:
                                                          GoogleFonts.poppins(
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w300),
                                                      border: InputBorder.none,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color: const Color.fromARGB(
                                                      223, 255, 255, 255)),
                                              height: 45,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                            ),
                                          );
                                        },
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 20, right: 20, top: 30),
                                        child: InkWell(
                                          onTap: () {
                                            var value = _controller.text;
                                            if (value.isEmpty) {
                                              print("Error State");
                                            } else {
                                              Navigator.pop(context);
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(SnackBar(
                                                      content: Text(
                                                          "Your State is updated")));
                                            }
                                          },
                                          child: Container(
                                            child: Center(
                                              child: Text(
                                                "UPDATE",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 16),
                                              ),
                                            ),
                                            height: 42,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: Color(0xFF2C41FF),
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
                          ))
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 15),
              child: Container(
                height: 40,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8)),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 250,
                        child: Row(
                          children: [
                            Icon(
                              Icons.support_agent_outlined,
                              color: const Color.fromARGB(117, 0, 0, 0),
                              size: 23,
                            ),
                            Gap(5),
                            Text(
                              "Support",
                              style: TextStyle(
                                  color: const Color.fromARGB(117, 0, 0, 0),
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
                            color: const Color.fromARGB(117, 0, 0, 0),
                          ))
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 15),
              child: Container(
                height: 40,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8)),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Container(
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
                              color: const Color.fromARGB(117, 0, 0, 0),
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
      ),
    );
  }
}
