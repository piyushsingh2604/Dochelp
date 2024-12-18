import 'package:dochelp/Worker/Appointment.dart';
import 'package:flutter/material.dart';

class WorkerAppointmentscreen extends StatefulWidget {
  String currentid;
  WorkerAppointmentscreen({super.key, required this.currentid});
  @override
  State<WorkerAppointmentscreen> createState() =>
      _WorkerAppointmentscreenState();
}

class _WorkerAppointmentscreenState extends State<WorkerAppointmentscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: Text(
          "Appointments",
          style: TextStyle(
              color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Divider(
            color: const Color.fromARGB(136, 158, 158, 158),
            thickness: 1.2,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
            child: SizedBox(
                height: 497,
                width: MediaQuery.of(context).size.width,
                child: WorkerAppointmentWidget(userId: widget.currentid,)),
          ),
        ],
      ),
    );
  }
}
