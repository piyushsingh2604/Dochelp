//https://dribbble.com/shots/19102936-Online-Doctor-s-App-Medical-Appointments-Booking

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  DateTime currentDate = DateTime.now();
  DateTime? selectedDate;
  List<DateTime> selectableDates = [];
  String? selectedTime;
  List<String> selectableTimes = [];

  @override
  void initState() {
    super.initState();
    _generateSelectableDates();
    _generateSelectableTimes();
  }

  void _generateSelectableTimes() {
    selectableTimes = List.generate(10, (index) {
      return DateFormat.jm().format(DateTime(0, 0, 0, 12 + index));
    });
  }

  void _generateSelectableDates() {
    selectableDates = List.generate(5, (index) {
      return DateTime.now().add(Duration(days: index));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
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
          height: 850,
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
                      onTap: (){},
                      child: Container(
                        height: 35,
                        width: 35,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(7),
                            color: Color(0xFFFBECEE)),
                        child: Center(
                            child: Icon(
                          Icons.favorite,
                          size: 19,
                          color: Color(0xFFFC4848),
                        )),
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
                            borderRadius: BorderRadius.circular(110)),
                      ),
                      Gap(10),
                      Text(
                        "Satyam Panday",
                        style: GoogleFonts.roboto(
                            fontSize: 15, fontWeight: FontWeight.w400),
                      ),
                      Gap(2),
                      Text(
                        "Hair dresser",
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
                    padding:
                        const EdgeInsets.only(bottom: 50, left: 30, right: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 50,
                          width: 150,
                          child: Stack(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    color: Color(0xFF4A689C),
                                    borderRadius: BorderRadius.circular(41)),
                                height: 46,
                                width: 46,
                                child: Center(
                                  child: Icon(
                                    Icons.person_add_alt_outlined,
                                    size: 24,
                                    color: Color(0xFFC5CFDF),
                                  ),
                                ),
                              ),
                              Positioned(
                                  left: 58,
                                  child: Text(
                                    "1000+",
                                    style: GoogleFonts.roboto(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w300,
                                        color: Colors.white),
                                  )),
                              Positioned(
                                  left: 60,
                                  top: 23,
                                  child: Text(
                                    "Patients",
                                    style: GoogleFonts.roboto(
                                        fontSize: 13,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w300),
                                  ))
                            ],
                          ),
                        ),
                        Container(
                          height: 50,
                          width: 150,
                          child: Stack(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    color: Color(0xFF4A689C),
                                    borderRadius: BorderRadius.circular(41)),
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
                                    "5 Years",
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20, top: 25),
                        child: Text(
                          "Biography",
                          style: GoogleFonts.roboto(
                              fontSize: 17,
                              fontWeight: FontWeight.w400,
                              color: Colors.black),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 20, top: 10, right: 40),
                        child: Text(
                          "Biography hi my name is satyam panday i am a hair dresser from mumbai my salon is in nallasopara east ",
                          style: GoogleFonts.roboto(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: const Color.fromARGB(236, 158, 158, 158)),
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
                          height: 90, // Set a height for the horizontal list
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: selectableDates.length,
                            itemBuilder: (context, index) {
                              DateTime date = selectableDates[index];
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedDate = date;
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
                                          spreadRadius: 1)
                                    ],
                                    color: selectedDate != null &&
                                            selectedDate!.isAtSameMomentAs(date)
                                        ? Color(0xFF1B4083)
                                        : Colors.white,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      // Abbreviated day of the week
                                      Text(
                                        DateFormat('EEE')
                                            .format(date), // Abbreviated day
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: selectedDate != null &&
                                                  selectedDate!
                                                      .isAtSameMomentAs(date)
                                              ? Colors.white
                                              : Colors.black,
                                          fontSize: 13,
                                        ),
                                      ),
                                      Gap(18),
                                      // Date
                                      Text(
                                        DateFormat('d')
                                            .format(date), // Day of the month
                                        style: TextStyle(
                                          color: selectedDate != null &&
                                                  selectedDate!
                                                      .isAtSameMomentAs(date)
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
                          height: 25, // Set a height for the horizontal list
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: selectableTimes.length,
                            itemBuilder: (context, index) {
                              String time = selectableTimes[index];
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedTime = time;
                                  });
                                },
                                child: Container(
                                  width: 105,
                                  margin: EdgeInsets.symmetric(horizontal: 8),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: const Color.fromARGB(
                                            255, 158, 158, 158),
                                        width: 0.2),
                                    color: selectedTime == time
                                        ? Color(0xFF1B4083)
                                        : Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Center(
                                    child: Text(time,
                                        style: GoogleFonts.roboto(
                                          color: selectedTime == time
                                              ? Colors.white
                                              : Color(0xFFA1A6B6),
                                          fontSize: 10,
                                          fontWeight: FontWeight.w400,
                                        )),
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
                                // Handle call action
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
                                onTap: () {
                                  // Handle appointment action
                                },
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
                    ],
                  ),
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
                  height: 900,
                  width: MediaQuery.of(context).size.width,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
