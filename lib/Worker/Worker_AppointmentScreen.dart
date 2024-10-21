import 'package:dochelp/Worker/Appointment.dart';
import 'package:flutter/material.dart';

class WorkerAppointmentscreen extends StatefulWidget {
  const WorkerAppointmentscreen({super.key});

  @override
  State<WorkerAppointmentscreen> createState() => _WorkerAppointmentscreenState();
}

class _WorkerAppointmentscreenState extends State<WorkerAppointmentscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
      backgroundColor: Colors.white,

        title: Text("Appointments",style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.w500),
        
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Divider(
              color: const Color.fromARGB(136, 158, 158, 158),
              thickness: 1.2,
            ),
        
        
        Padding(
          padding: const EdgeInsets.only(left: 20,right: 20,top: 20),
          child: SizedBox(
            height: 900,
            width: MediaQuery.of(context).size.width,
            child: WorkerAppointmentWidget()),
        ),
          ],
        ),
      ),
    );
  }
}