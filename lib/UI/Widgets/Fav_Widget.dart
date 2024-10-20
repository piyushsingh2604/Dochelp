import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class FavWidget extends StatelessWidget {
  const FavWidget({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: 100,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(19), color: Colors.white),
        child: Stack(
          children: [
            Positioned(
              left: 10,
              top: 11,
              child: Container(
                height: 77,
                width: 77,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.green),
              ),
            ),
            Positioned(
                left: 100,
                top: 19,
                child: Text(
                  "Salman Khan",
                  // style: TextStyle(
                  //     color: Colors.black,
                  //     fontSize: 14,
                  //     fontWeight: FontWeight.w600),
                  style: GoogleFonts.openSans(
                      fontSize: 15, fontWeight: FontWeight.w600),
                )),
            Positioned(
                left: 100,
                top: 45,
                child: Text(
                  "Hair Dresser",
                  style: GoogleFonts.roboto(
                      fontSize: 10, fontWeight: FontWeight.w400),

                  // style: TextStyle(
                  //     color: const Color.fromARGB(193, 0, 0, 0),
                  //     fontSize: 10,
                  //     fontWeight: FontWeight.w300),
                )),
            Positioned(
                top: 5,
                right: 5,
                child: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.favorite_outline_rounded,
                      color: Color(0xFFF31D53),
                      size: 19,
                    ))),
            Positioned(
              top: 70,
              left: 100,
              child: Row(
                children: [
                  Icon(
                    Icons.star,
                    size: 17,
                    color: Colors.yellow[600],
                  ),
                  Gap(4),
                  Text(
                    "4.9",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 13,
                        fontWeight: FontWeight.w100),
                  ),
                  Gap(1),
                  Text(
                    "(2436 Reviews)",
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 10,
                        fontWeight: FontWeight.w100),
                  )
                ],
              ),
            ),
            Positioned(
                top: 70,
                right: 20,
                child: Text(
                  "\$25/hr",
                  style: GoogleFonts.roboto(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFFF31D53),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}





