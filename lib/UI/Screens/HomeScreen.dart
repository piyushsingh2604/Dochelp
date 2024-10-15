import 'package:dochelp/UI/Widgets/Category_Widget.dart';
import 'package:dochelp/UI/Widgets/Popular_Widget.dart';
import 'package:dochelp/UI/Widgets/Swiper_Widget.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(
                          'https://static.vecteezy.com/system/resources/thumbnails/012/594/316/small_2x/turqoise-abstract-background-for-creative-business-bifold-brochure-template-png.png'),
                      fit: BoxFit.cover)),
              height: 280,
              width: MediaQuery.of(context).size.width,
              child: Stack(
                children: [
                  Positioned(
                      top: 40,
                      left: 20,
                      child: Text(
                        "Hello Satyam",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                      )),
                  Positioned(
                      top: 65,
                      left: 20,
                      child: Text(
                        "Good Morning",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w200,
                            color: const Color.fromARGB(202, 0, 0, 0)),
                      )),
                  Positioned(
                    top: 45,
                    right: 20,
                    child: Container(
                      child: Center(
                        child: Icon(
                          Icons.notifications_outlined,
                          color: const Color.fromARGB(189, 0, 0, 0),
                          size: 22,
                        ),
                      ),
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(40),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 20,
                    right: 20,
                    top: 110,
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 20, bottom: 8),
                            child: Container(
                              width: 200,
                              child: TextField(
                                readOnly: true,
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
                                  hintText: 'Search',
                                  hintStyle: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w100),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: 40,
                            width: 40,
                            child: Center(
                              child: Icon(
                                Icons.search,
                                color: Colors.white,
                                size: 18,
                              ),
                            ),
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(173, 26, 34, 126),
                              borderRadius: BorderRadius.circular(50),
                            ),
                          )
                        ],
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(22),
                          color: const Color.fromARGB(223, 255, 255, 255)),
                      height: 45,
                      width: MediaQuery.of(context).size.width,
                    ),
                  ),
                  Positioned(
                      left: 20,
                      top: 160,
                      child: Container(
                          height: 100,
                          width: MediaQuery.of(context).size.width,
                          child: CategoryWidget()))
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 15),
              child: Text(
                "Top Workes",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 18),
              ),
            ),
            Gap(0),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 189 ,
              child: SwiperWidget(),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 5, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Popular Salons",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 18),
                  ),
                  TextButton(
                      onPressed: () {},
                      child: Text(
                        "See All",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Color(0xFFfebbe6)),
                      ))
                ],
              ),
            ),
        Padding(
          padding: const EdgeInsets.only(left: 20,right: 20,top: 15),
          child: Container(
            height: 500,
            width: MediaQuery.of(context).size.width,
            child: PopularWidget(),
          ),
        )
          ],
        ),
      ),
    );
  }
}
