



import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

class WorkerAppointmentWidget extends StatelessWidget {
  final String userId; // The profile user's ID

  const WorkerAppointmentWidget({super.key, required this.userId});

  // Function to parse the date from the appointment
  DateTime? parseDate(String dateString) {
    try {
      return DateFormat('yyyy-MM-dd').parse(dateString);
    } catch (e) {
      print('Error parsing date: $dateString');
      return null; // Return null if parsing fails
    }
  }

  // Function to determine the status of the appointment
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
      return "Up coming";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('appointments')
            .where('profileUserId', isEqualTo: userId) // Fetching appointments for the user
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
              DateTime? appointmentDate = parseDate(appointment['date'] ?? '');
              if (appointmentDate == null) {
                return Center(child: Text('Invalid date format for appointment.'));
              }

              // Get the appointment status
              String status = getAppointmentStatus(appointmentDate);

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
                            : (status == "Today"
                                ? Colors.green
                                : (status == "Tomorrow" ? Colors.blue : Colors.orange)),
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Container(
                      height: 165,
                      width: 210,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 10,
                            spreadRadius: 0.4,
                            color: const Color.fromARGB(59, 158, 158, 158),
                          ),
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                            top: 15,
                            left: 18,
                            child: Text(
                              appointment['currentname'] ?? "",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 15,
                              ),
                            ),
                          ),
                          Positioned(
                            top: 37,
                            left: 18,
                            child: Text(
                              appointment['work'] ?? "",
                              style: TextStyle(
                                color: const Color.fromARGB(104, 0, 0, 0),
                                fontWeight: FontWeight.w400,
                                fontSize: 10,
                              ),
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
                                  onTap: () async {
                                    // Update the appointment status to accepted
                                    await FirebaseFirestore.instance.collection('appointments').doc(docId).update({
                                      'status': 'accepted',
                                    });
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
                                        "Accept",
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
                              decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(5)),
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
}
