import 'package:dochelp/UI/Widgets/Category_Widget.dart';
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
            backgroundColor: Colors.grey[50],

     // backgroundColor: Colors.pink[50],
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
image: DecorationImage(image: NetworkImage('https://static.wixstatic.com/media/28a571_b921a6a84b5f4782b75ee172829cec53~mv2.png/v1/crop/x_0,y_2,w_1685,h_2996/fill/w_242,h_416,al_c,q_85,usm_0.66_1.00_0.01,enc_auto/hiclipart_edited.png'),fit: BoxFit.cover)            ),
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
                             color:const Color.fromARGB(223, 255, 255, 255)),
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
            padding: const EdgeInsets.only(left: 20,top: 15),
            child: Text("Top Workes",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600,fontSize: 18),),
          ),
Gap(1),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 188,
            child: SwiperWidget(),
          ),
  Padding(
            padding: const EdgeInsets.only(left: 20,top: 15,right: 20),
            child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Popular Salons",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600,fontSize: 18),),
             TextButton(onPressed: (){}, child: Text("See All",style: TextStyle(),))
              ],
            ),
          ),        ],
      ),
    );
  }
}
