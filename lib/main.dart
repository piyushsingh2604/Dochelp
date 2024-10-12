import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dochelp/UI/Widgets/BottomBar.dart';
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
      home: Test(),
    );
  }
}

class Test extends StatefulWidget {
  const Test({super.key});

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Doctor List"),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('doctor').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text("Error: ${snapshot.error}"),
            );
          } else if (snapshot.hasData) {
            final docs = snapshot.data!.docs;

            List<Widget> cards = docs.map((doc) {
              var data = doc.data() as Map<String, dynamic>;
              return Card(
                  child: Container(
                child: Stack(
                  children: [
                    Positioned(
                      top: 15,
                      left: 20,
                      child: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(60)),
                      ),
                    )
                  ],
                ),
              ));
            }).toList();

            return Container(
              height: 190,
              width: MediaQuery.of(context).size.width,
              child: CardSwiper(
                backCardOffset: Offset(15, 15),
                cardsCount: cards.length,
                cardBuilder:
                    (context, index, percentThresholdX, percentThresholdY) =>
                        cards[index],
              ),
            );
          } else {
            return Center(
              child: Text("No data found"),
            );
          }
        },
      ),
    );
  }
}



// https://dribbble.com/shots/17886683-Medical-Mobile-App-Design-Case-Study
// https://github.com/sunilvijayan7/GetDoctor
// appointment
// https://dribbble.com/shots/20688641-Telemedicine-Mobile-App
//home
// https://dribbble.com/shots/22701244-Doctor-App