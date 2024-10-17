import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dochelp/UI/Screens/HomeScreen.dart';
import 'package:dochelp/UI/Widgets/BottomBar.dart';
import 'package:dochelp/UI/Widgets/Swiper_Widget.dart';
import 'package:dochelp/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';

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
      home: BottomBar(),
    );
  }
}






// https://dribbble.com/shots/17886683-Medical-Mobile-App-Design-Case-Study
// https://github.com/sunilvijayan7/GetDoctor
// appointment
// https://dribbble.com/shots/20688641-Telemedicine-Mobile-App
//Profile
// https://cdn.dribbble.com/users/7180606/screenshots/19696717/media/c9f10fb6c2b56624aa9f0f000a45b707.jpg?resize=1600x1200&vertical=center
// edit profile 
// https://cdn.dribbble.com/users/1346977/screenshots/5771597/media/f8d6a31f723a132ef0131b6879f4530c.png?resize=800x600&vertical=center