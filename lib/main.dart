
import 'package:dochelp/Auth/Login.dart';
import 'package:dochelp/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Login(),
    );
  }
}


// https://mir-s3-cdn-cf.behance.net/project_modules/1400/89413d141786591.625a8fc55babb.jpg

 
class AppointmentScreen extends StatefulWidget {
  @override
  _AppointmentScreenState createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
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
      appBar: AppBar(title: Text('Book an Appointment')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 25),
              child: Text(
                "Appointment",
                style: GoogleFonts.roboto(
                  fontSize: 17,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
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
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.all(6),
                        height: 40,
                        width: 48,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: const Color.fromARGB(31, 158, 158, 158),
                              blurRadius: 1,
                              spreadRadius: 1,
                            )
                          ],
                          color: selectedDate != null && selectedDate!.isAtSameMomentAs(date)
                              ? Color(0xFF1B4083)
                              : Colors.white,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              DateFormat('EEE').format(date),
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: selectedDate != null && selectedDate!.isAtSameMomentAs(date)
                                    ? Colors.white
                                    : Colors.black,
                                fontSize: 13,
                              ),
                            ),
                            SizedBox(height: 18),
                            Text(
                              DateFormat('d').format(date),
                              style: TextStyle(
                                color: selectedDate != null && selectedDate!.isAtSameMomentAs(date)
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
                "Schedule",
                style: GoogleFonts.roboto(
                  fontSize: 17,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
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
                        });
                      },
                      child: Container(
                        width: 105,
                        margin: EdgeInsets.symmetric(horizontal: 8),
                        decoration: BoxDecoration(
                          border: Border.all(color: const Color.fromARGB(255, 158, 158, 158), width: 0.2),
                          color: selectedTime == time ? Color(0xFF1B4083) : Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Text(
                            time,
                            style: GoogleFonts.roboto(
                              color: selectedTime == time ? Colors.white : Color(0xFFA1A6B6),
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
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      // Placeholder for call functionality
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
                  SizedBox(width: 10),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        if (selectedDate != null && selectedTime != null) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CheckDataScreen(
                                selectedDate: selectedDate,
                                selectedTime: selectedTime,
                              ),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Please select a date and time.')),
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
      ),
    );
  }
}

class CheckDataScreen extends StatelessWidget {
  final DateTime? selectedDate;
  final String? selectedTime;

  CheckDataScreen({this.selectedDate, this.selectedTime});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Appointment Confirmation')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Selected Date: ${selectedDate != null ? DateFormat('yyyy-MM-dd').format(selectedDate!) : 'None'}',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              'Selected Time: ${selectedTime ?? 'None'}',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
