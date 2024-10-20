
import 'package:dochelp/UI/Screens/ProfileScreen.dart';
import 'package:dochelp/UI/Widgets/BottomBar.dart';
import 'package:dochelp/Worker/Appointment.dart';
import 'package:dochelp/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

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
//https://camo.envatousercontent.com/14858b9f34c7c83e76118fe80d8e90d7e93c6c6d/68747470733a2f2f646c2e64726f70626f7875736572636f6e74656e742e636f6d2f732f78747435637531776436306f666d622f466f726d2e706e673f5f633d31363131323133313933343731363033303135333937343036323736265f633d31363131323133313933343731363033303135333937265f633d31363131323133313933343731363033265f633d31363131323133313933