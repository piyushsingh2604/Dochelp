import 'package:dochelp/UI/Widgets/Appointment_Widget.dart';
import 'package:dochelp/UI/Widgets/Fav_Widget.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class FavScreen extends StatefulWidget {
  const FavScreen({super.key});

  @override
  State<FavScreen> createState() => _FavScreenState();
}

class _FavScreenState extends State<FavScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
            backgroundColor: Color(0xFFF7F8F9),

      appBar: AppBar(
              backgroundColor: Color(0xFFF7F8F9),

        title: Text("Favorites",style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.w500),
        
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
          child: Container(
            height: 900,
            width: MediaQuery.of(context).size.width,
            child: FavWidget()),
        ),
          ],
        ),
      ),
    );
  }
}