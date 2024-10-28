import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';





class WorkerAppointmentWidget extends StatelessWidget {
  final String userId; // The profile user's ID

  WorkerAppointmentWidget({super.key, required this.userId});

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
              return  SizedBox(
        height: 170,
        width: MediaQuery.of(context).size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Today",style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.w600),),
              Container(
                          height: 165,
                          width: 210,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 10,
                                spreadRadius: 0.4,
                                color: const Color.fromARGB(59, 158, 158, 158)
                              )
                            ],
              color: Colors.white, borderRadius: BorderRadius.circular(15)),
                          child: Stack(
                            children: [
              Positioned(
                  top: 15,
                  left: 18,
                  child: Text(
                   appointment['Profileusername']??"",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 15),
                  )),
              Positioned(
                  top: 37,
                  left: 18,
                  child: Text(
                    appointment['work']??"",
                    style: TextStyle(
                        color: const Color.fromARGB(104, 0, 0, 0),
                        fontWeight: FontWeight.w400,
                        fontSize: 10),
                  )),
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
                          padding: const EdgeInsets.only(
                            left: 15,
                          ),
                          child: SizedBox(
                            height: 20,
                            width: 95,
                            child: Row(
                              children: [
                                Icon(
                                  Icons.calendar_month_outlined,
                                  size: 14,
                                  color: Color(0xFF2C41FF),
                                ),
                                Gap(3),
                                Text(
                                  appointment['date']??"",
                                  style: TextStyle(
                                      fontSize: 9,
                                      color: const Color.fromARGB(
                                          171, 158, 158, 158)),
                                )
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 6,
                          ),
                          child: SizedBox(
                            height: 20,
                            width: 95,
                            child: Row(
                              children: [
                                Icon(
                                  Icons.access_time,
                                  size: 14,
                                  color: Color(0xFF2C41FF),
                                ),
                                Gap(3),
                                Text(
                                  appointment['time']??"",
                                  style: TextStyle(
                                      fontSize: 9,
                                      color: const Color.fromARGB(
                                          171, 158, 158, 158)),
                                )
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
                    Container(
                      height: 35,
                      width: 75,
                      decoration: BoxDecoration(
                          border: Border.all(
                              color:
                                  const Color.fromARGB(85, 158, 158, 158)),
                          borderRadius: BorderRadius.circular(5)),
                      child: Center(
                        child: Text(
                          "Cancel",
                          style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                              color:
                                  const Color.fromARGB(212, 158, 158, 158)),
                        ),
                      ),
                    ),
                    Gap(5),
                    Container(
                      height: 35,
                      width: 97,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(32, 158, 158, 158),borderRadius: BorderRadius.circular(5)
                      ),
                      child: Center(
                        child: Text("Accept",style: TextStyle(fontSize: 11,fontWeight: FontWeight.w600,color:  Color(0xFF2C41FF)),),
                      ),
                    )
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
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(5)
                  ),
                ),
              )
                            ],
                          ),
                        )
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