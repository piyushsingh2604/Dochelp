import 'package:dochelp/UI/Screens/AddMoney.dart';
import 'package:flutter/material.dart';





class AmountWidget extends StatefulWidget {
  const AmountWidget({super.key});

  @override
  State<AmountWidget> createState() => _AmountWidgetState();
}

class _AmountWidgetState extends State<AmountWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Addmoney(),
              ));
        },
        child: Container(
          height: 46,
          width: 110,
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    color: const Color.fromARGB(40, 158, 158, 158),
                    spreadRadius: 3,
                    blurRadius: 2)
              ],
              color: Colors.white,
              borderRadius: BorderRadius.circular(30)),
          child: Stack(
            children: [
              Positioned(
                  top: 2,
                  left: 15,
                  child: Text(
                    '\u{20B9}',
                    style: TextStyle(
                        color: Colors.black54,
                        fontSize: 30,
                        fontWeight: FontWeight.w500),
                  )),
              Positioned(
                  top: 5,
                  left: 40,
                  child: Text(
                    "Balance",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 10),
                  )),
              Positioned(
                  left: 39.4,
                  top: 16.7,
                  child: Text(
                    "2,000",
                    style: TextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.w500,
                        fontSize: 15),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
