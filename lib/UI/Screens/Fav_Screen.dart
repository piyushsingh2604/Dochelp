import 'package:dochelp/UI/Widgets/Fav_Widget.dart';
import 'package:flutter/material.dart';

class FavScreen extends StatelessWidget {
  final String userId;
  String currentname;

   FavScreen({super.key, required this.userId,required this.currentname});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF7F8F9),
      appBar: AppBar(
        backgroundColor: Color(0xFFF7F8F9),
        automaticallyImplyLeading: false,
        title: Text(
          "Favorites",
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
            
                height: 500,
                width: MediaQuery.of(context).size.width,
                child: FavWidget(
                  currentname: currentname,
                  userId: userId,
                )),
          ),
        ],
      ),
    );
  }
}
