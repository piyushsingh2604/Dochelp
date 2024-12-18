import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

class AppointmentWidget extends StatelessWidget {
  final String userId; // The profile user's ID

  const AppointmentWidget({super.key, required this.userId});

  DateTime? parseDate(String dateString) {
    try {
      return DateFormat('yyyy-MM-dd').parse(dateString); // Update format here
    } catch (e) {
      print('Error parsing date: $dateString');
      return null; // Return null if parsing fails
    }
  }

  String getAppointmentStatus(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day); // Midnight of today
    final tomorrow = today.add(Duration(days: 1)); // Midnight of tomorrow

    if (date.isBefore(today)) {
      return "Done";
    } else if (date.isAtSameMomentAs(today)) {
      return "Today";
    } else if (date.isAtSameMomentAs(tomorrow)) {
      return "Tomorrow";
    } else {
      return "Waiting";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('appointments')
            .where('userId', isEqualTo: userId) // Fetching appointments for the user
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }
          if (snapshot.hasData && snapshot.data!.docs.isEmpty) {
            return Center(child: Text("No appointments found."));
          }

          final appointments = snapshot.data!.docs;

          return ListView.builder(
            itemCount: appointments.length,
            itemBuilder: (context, index) {
              var appointment = appointments[index].data() as Map<String, dynamic>;
              var docId = appointments[index].id; // Get the document ID

              // Parse the appointment date
              final appointmentDate = parseDate(appointment['date'] ?? '');
              if (appointmentDate == null) {
                return Center(child: Text('Invalid date format for appointment.'));
              }

              // Get the appointment status
              final status = getAppointmentStatus(appointmentDate);

              return SizedBox(
                height: 170,
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      status,
                      style: TextStyle(
                        color: status == "Done"
                            ? Colors.red
                            : (status == "Today" ? Colors.green : Colors.orange),
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Container(
                      height: 165,
                      width: 210,
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15)),
                      child: Stack(
                        children: [
                          Positioned(
                            top: 15,
                            left: 18,
                            child: Text(
                              appointment['Profileusername'] ?? "",
                              style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 15),
                            ),
                          ),
                          Positioned(
                            top: 37,
                            left: 18,
                            child: Text(
                              appointment['work'] ?? "",
                              style: TextStyle(color: const Color.fromARGB(104, 0, 0, 0), fontWeight: FontWeight.w400, fontSize: 10),
                            ),
                          ),
                          Positioned(
                            top: 65,
                            child: Container(
                              height: 30,
                              width: MediaQuery.of(context).size.width,
                              color: const Color.fromARGB(16, 158, 158, 158),
                              child: Center(
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 15),
                                      child: SizedBox(
                                        height: 20,
                                        width: 95,
                                        child: Row(
                                          children: [
                                            Icon(Icons.calendar_month_outlined, size: 14, color: Color(0xFF2C41FF)),
                                            Gap(3),
                                            Text(
                                              appointment['date'] ?? "",
                                              style: TextStyle(fontSize: 9, color: const Color.fromARGB(171, 158, 158, 158)),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 6),
                                      child: SizedBox(
                                        height: 20,
                                        width: 95,
                                        child: Row(
                                          children: [
                                            Icon(Icons.access_time, size: 14, color: Color(0xFF2C41FF)),
                                            Gap(3),
                                            Text(
                                              appointment['time'] ?? "",
                                              style: TextStyle(fontSize: 9, color: const Color.fromARGB(171, 158, 158, 158)),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 110,
                            left: 15,
                            child: Row(
                              children: [
                                InkWell(
                                  onTap: () async {
                                    // Delete the appointment from Firestore
                                    await FirebaseFirestore.instance.collection('appointments').doc(docId).delete();
                                  },
                                  child: Container(
                                    height: 35,
                                    width: 75,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: const Color.fromARGB(85, 158, 158, 158)),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "Cancel",
                                        style: TextStyle(fontSize: 11, fontWeight: FontWeight.w500, color: const Color.fromARGB(212, 158, 158, 158)),
                                      ),
                                    ),
                                  ),
                                ),
                                Gap(5),
                                InkWell(
                                  onTap: () {
                                    showAlertDialog(context, appointment['address'] ?? ""); // Pass the context and address
                                  },
                                  child: Container(
                                    height: 35,
                                    width: 97,
                                    decoration: BoxDecoration(
                                      color: const Color.fromARGB(32, 158, 158, 158),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "Address",
                                        style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Color(0xFF2C41FF)),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            top: 15,
                            right: 15,
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: ClipOval(
                                child: Image.network(
                                  appointment['imageUrl'] != null && appointment['imageUrl'] is String
                                      ? appointment['imageUrl'] // Use the image URL directly
                                      : 'https://cdn-icons-png.flaticon.com/512/3135/3135715.png', // Default fallback image URL
                                  fit: BoxFit.cover,
                                  height: 40,
                                  width: 40,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Image.network(
                                      'https://cdn-icons-png.flaticon.com/512/3135/3135715.png', // Fallback image on error
                                      fit: BoxFit.cover,
                                      height: 40,
                                      width: 40,
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  void showAlertDialog(BuildContext context, String address) {
    // Set up the button
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // Set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Shop Address"),
      content: Text(address),
      actions: [
        okButton,
      ],
    );

    // Show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
