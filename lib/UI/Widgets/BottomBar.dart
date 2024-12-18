import 'package:dochelp/UI/Screens/AppointmentScreen.dart';
import 'package:dochelp/UI/Screens/Fav_Screen.dart';
import 'package:dochelp/UI/Screens/HomeScreen.dart';
import 'package:dochelp/UI/Screens/ProfileScreen.dart';
import 'package:flutter/material.dart';
import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';


class BottomBar extends StatefulWidget {
  String name;
  String currentuid;
  BottomBar({super.key, 
    required this.currentuid,
    required this.name,
  });
  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  final PageController _pageController = PageController();
  final NotchBottomBarController _notchBottomBarController =
      NotchBottomBarController();
  int _currentIndex = 0;

  void _onTap(int index) {
    setState(() {
      _currentIndex = index;
    });
    _pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF7F8F9),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        children: [
          HomeScreen(name: widget.name,uid: widget.currentuid,),
          FavScreen(userId: widget.currentuid,currentname: widget.name,),
          Appointmentscreen(currentid: widget.currentuid,),
          Profilescreen(),
        ],
      ),
      bottomNavigationBar: AnimatedNotchBottomBar(
        notchBottomBarController: _notchBottomBarController,
        bottomBarItems: [
          BottomBarItem(
            inActiveItem: Icon(
              Icons.home_outlined,
              color: Colors.blueGrey,
            ),
            activeItem: Icon(
              Icons.home_filled,
              color: Color(0xFF2C41FF),
            ),
            itemLabel: 'Home',
          ),
          BottomBarItem(
            inActiveItem: Icon(
              Icons.favorite_border,
              color: Colors.blueGrey,
            ),
            activeItem: Icon(
              Icons.favorite,
              color: Color(0xFF2C41FF),
            ),
            itemLabel: 'Favorites',
          ),
          BottomBarItem(
            inActiveItem: Icon(
              Icons.calendar_month_outlined,
              color: Colors.blueGrey,
            ),
            activeItem: Icon(
              Icons.calendar_month,
              color: Color(0xFF2C41FF),
            ),
            itemLabel: 'Appointment',
          ),
          BottomBarItem(
            inActiveItem: Icon(
              Icons.person_outline_sharp,
              color: Colors.blueGrey,
            ),
            activeItem: Icon(
              Icons.person,
              color: Color(0xFF2C41FF),
            ),
            itemLabel: 'Profile',
          ),
        ],
        onTap: _onTap,
        kIconSize: 30.0, // Example icon size
        kBottomRadius: 25.0, // Example bottom radius
      ),
    );
  }
}
