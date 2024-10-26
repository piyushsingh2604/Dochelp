// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_card_swiper/flutter_card_swiper.dart';




// class SwiperWidget extends StatefulWidget {
//   const SwiperWidget({super.key});

//   @override
//   State<SwiperWidget> createState() => _SwiperWidgetState();
// }

// class _SwiperWidgetState extends State<SwiperWidget> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//           backgroundColor: Colors.transparent,

//       body: StreamBuilder<QuerySnapshot>(
//         stream: FirebaseFirestore.instance.collection('doctor').snapshots(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(
//               child: CircularProgressIndicator(),
//             );
//           } else if (snapshot.hasError) {
//             return Center(
//               child: Text("Error: ${snapshot.error}"),
//             );
//           } else if (snapshot.hasData) {
//             final docs = snapshot.data!.docs;

//             List<Widget> cards = docs.map((doc) {
//               var data = doc.data() as Map<String, dynamic>;
//               return Card(
//                   child: Container(
//                 decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(10),
//                     image: DecorationImage(
//                         image: NetworkImage(
//                             'https://t4.ftcdn.net/jpg/03/41/16/09/360_F_341160981_CFBrQpnDWWuMZqTpDPvOkHcdZeEikeXm.jpg'),
//                         fit: BoxFit.cover)),
//                 child: Stack(
//                   children: [
//                     Positioned(
//                       top: 15,
//                       left: 20,
//                       child: Container(
//                         height: 50,
//                         width: 50,
//                         decoration: BoxDecoration(
//                             color: Colors.green,
//                             borderRadius: BorderRadius.circular(60)),
//                       ),
//                     ),
//                     Positioned(
//                       top: 25,
//                       right: 20,
//                       child: Container(
//                         child: Center(
//                           child: Icon(Icons.call,color: Colors.white,size: 17,),
//                         ),
//                         height: 40,
//                         width: 40,
//                         decoration: BoxDecoration(
//                           color: const Color.fromARGB(58, 255, 255, 255),
//                           borderRadius: BorderRadius.circular(40),
//                         ),
//                       ),
//                     ),
//                     Positioned(
//                         top: 16,
//                         left: 85,
//                         child: Text(
//                           "Singh Piyush",
//                           style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 18,
//                               fontWeight: FontWeight.w700),
//                         )),
//                     Positioned(
//                         top: 45,
//                         left: 85,
//                         child: Text(
//                           "Dentist",
//                           style: TextStyle(
//                               color: const Color.fromARGB(159, 255, 255, 255),
//                               fontSize: 12,
//                               fontWeight: FontWeight.w400),
//                         )),
//                         Positioned(
//                           left: 20,
//                           right: 20,
//                           top: 85,
//                           child: Container(
//                             child: Padding(
//                               padding: const EdgeInsets.only(left: 10,right: 10),
//                               child: Row(
//                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Container(
//                                     width: 70,
//                                     height: 20,
//                                     child: Row(
//                                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                       children: [
//                                         Icon(Icons.calendar_month_outlined,color: Colors.white,size: 15,),
//                                         Text("June 12",style: TextStyle(color: Colors.white,fontSize: 13),)
//                                       ],
//                                     ),
//                                   ),
//                                       Container(
//                                     width: 70,
//                                     height: 20,
//                                     child: Row(
//                                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                       children: [
//                                         Icon(Icons.access_time_rounded,color: Colors.white,size: 15,),
//                                         Text("9:30 AM",style: TextStyle(color: Colors.white,fontSize: 13),)
//                                       ],
//                                     ),
//                                   )
//                                 ],
//                               ),
//                             ),
//                             height: 30,
//                             width: MediaQuery.of(context).size.width,
//                             decoration: BoxDecoration(
//                               color: const Color.fromARGB(64, 255, 255, 255),
//                               borderRadius: BorderRadius.circular(7)
//                             ),
//                           ),
//                         )
//                   ],
//                 ),
//               ));
//             }).toList();

//             return Container(
//               height: 190,
//               width: MediaQuery.of(context).size.width,
//               child: CardSwiper(
//                 backCardOffset: Offset(15, 15),
//                 cardsCount: cards.length,
//                 cardBuilder:
//                     (context, index, percentThresholdX, percentThresholdY) =>
//                         cards[index],
//               ),
//             );
//           } else {
//             return Center(
//               child: Text("No data found"),
//             );
//           }
//         },
//       ),
//     );
//   }
// }





import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';


class Slider_Widget extends StatefulWidget {
  const Slider_Widget({super.key});

  @override
  State<Slider_Widget> createState() => _Slider_WidgetState();
}

class _Slider_WidgetState extends State<Slider_Widget> {
  int outerCurrentPage = 0;
  final PageController _pageController = PageController();

  // List of colors to display in the outer banner slider
  final List<String> banner = [
   'https://d1csarkz8obe9u.cloudfront.net/posterpreviews/beauty-salon-banner-ad-design-template-882e4c92d5c005fa1237eb393f8dafb5_screen.jpg?ts=1646469155',
   'https://5.imimg.com/data5/FI/SQ/MY-34687665/salon-banner-500x500.jpg',
   'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQzsY2bN5xKskbQ9zB5wGrx5o-bXceYCKqrac8rL3xMLI76ZBDIy-otcybCkmKOaX0Mm14&usqp=CAU',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _outerBannerSlider(),
        ],
      ),
    );
  }

  /// Outer Style Indicators Banner Slider
  Widget _outerBannerSlider() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 1,right: 1),
          child: SizedBox(
            width: double.infinity,
            height: 145, // Set the height of the CarouselSlider here
            child: CarouselSlider(
              options: CarouselOptions(autoPlayInterval: Duration(seconds: 20),
                autoPlay: true,
                enlargeCenterPage: true,
                enableInfiniteScroll: true,
                aspectRatio: 16 / 8,
                viewportFraction: .99,
                onPageChanged: (index, reason) {
                  setState(() {
                    outerCurrentPage = index;
                  });
                },
              ),
          
              /// Items with color containers
              items: banner.map((imageUrl) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      height: 145, // Set the height of the container here
                      decoration: BoxDecoration(
                        image: DecorationImage(image: NetworkImage(imageUrl),fit: BoxFit.fill),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      width: MediaQuery.of(context).size.width,
                    );
                  },
                );
              }).toList(),
            ),
          ),
        ),

        /// Indicators for the slider
      ],
    );
  }
}