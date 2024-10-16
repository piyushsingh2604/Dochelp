import 'package:flutter/material.dart';

class TopworkesWidget extends StatelessWidget {
  const TopworkesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20,right: 20),
            child: Container(
              height: 70,
              width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.white
            ),
            ),
          )
        ],
      ),
    );
  }
}