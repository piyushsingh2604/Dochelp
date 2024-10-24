import 'package:dochelp/UI/Widgets/Category_Widget.dart';
import 'package:dochelp/UI/Widgets/Swiper_Widget.dart';
import 'package:dochelp/UI/Widgets/TopWorkes_Widget.dart';
import 'package:dochelp/Worker/BottomBar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  String name;
  HomeScreen({required this.name});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF7F8F9),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 410,
              width: MediaQuery.of(context).size.width,
              child: Stack(
                children: [
                  Positioned(
                      top: 59,
                      left: 20,
                      child: Text(
                        "Keep Healthy!",
                        style: GoogleFonts.roboto(
                            fontSize: 25, fontWeight: FontWeight.w600),
                        // TextStyle(
                        //     fontSize: 19,
                        //     fontWeight: FontWeight.w600,
                        //     color: Colors.black),
                      )),
                  Positioned(
                      top: 40,
                      left: 20,
                      child: Text(
                        "Hello ${widget.name}",
                        style: GoogleFonts.roboto(
                            fontSize: 14, fontWeight: FontWeight.w300),

                        //  TextStyle(
                        //     fontSize: 14,
                        //     fontWeight: FontWeight.w100,
                        //     color: const Color.fromARGB(158, 0, 0, 0)),
                      )),
                  Positioned(
                    top: 30,
                    right: 20,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => WorkerBottomBar(),
                            ));
                      },
                      child: Container(
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(60),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 20,
                    right: 20,
                    top: 110,
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color.fromARGB(223, 255, 255, 255)),
                      height: 45,
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20, bottom: 16),
                        child: SizedBox(
                          width: 200,
                          child: TextField(
                            // readOnly: true,
                            onTap: () {
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //       builder: (context) =>
                              //           SearchScreen(id: widget.uid),
                              //     ));
                            },
                            cursorHeight: 16,
                            decoration: InputDecoration(
                              hintText: 'Search Salon or anything',
                              hintStyle: GoogleFonts.poppins(
                                  fontSize: 12, fontWeight: FontWeight.w300),
                              // TextStyle(
                              //     color: Colors.grey,
                              //     fontWeight: FontWeight.w100),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 170,
                    left: 20,
                    right: 20,
                    child: SizedBox(
                      height: 145,
                      width: MediaQuery.of(context).size.width,
                      child: Slider_Widget(),
                    ),
                  ),
                  Positioned(
                      right: 10,
                      left: 20,
                      top: 330,
                      child: SizedBox(
                          height: 73,
                          width: MediaQuery.of(context).size.width,
                          child: CategoryWidget()))
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 1, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Top Salons",
                    style: GoogleFonts.notoSansGurmukhi(
                        fontSize: 19, fontWeight: FontWeight.w600),
                    // style: TextStyle(
                    //     color: Colors.black,
                    //     fontWeight: FontWeight.w600,
                    //     fontSize: 18),
                  ),
                  TextButton(
                      onPressed: () {},
                      child: Text(
                        "See All",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF2C41FF),
                        ),
                      ))
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 3),
              child: SizedBox(
                height: 500,
                width: MediaQuery.of(context).size.width,
                child: TopworkesWidget(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
