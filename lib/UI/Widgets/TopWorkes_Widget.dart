import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class TopworkesWidget extends StatelessWidget {
  const TopworkesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        child: Stack(
          children: [
            Positioned(
              left: 6,
              top: 5,
              child: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(color: Colors.green,borderRadius: BorderRadius.circular(15)),
              ),
            ),
            Positioned
            
            (
              left: 67,
              top: 5,
              child: Text("Dhayu Erprida",style: GoogleFonts.montserrat(
                fontSize: 14, fontWeight: FontWeight.w500),)),
               Positioned
            
            (
              left: 67,
              top: 33,
              child: Text("Hair Dresser",style: GoogleFonts.montserrat(
                fontSize: 11, fontWeight: FontWeight.w400),)),
              Positioned( top: 10,right: 15,
            
                child: Container(
                  height: 40,
                  child: Row(
                    children: [
                        Container(
                          height: 15,
                          width: 15,
                          decoration: BoxDecoration(image: DecorationImage(image: NetworkImage('https://png.pngtree.com/png-vector/20230525/ourmid/pngtree-glossy-yellow-star-hd-image-vector-png-image_7108442.png'))),
                        ),
                                  Gap(4),
                                  Text(
                "4.9",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 13,
                    fontWeight: FontWeight.w100),
                                  ),
                    ],
                  ),
                ),
              )
          ],
        ),
        height: 60,
        width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(17),
        color: Colors.white
      ),
      ),
    );
  }
}