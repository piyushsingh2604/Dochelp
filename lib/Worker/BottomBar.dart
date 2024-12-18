
import 'package:dochelp/Worker/Profile.dart';
import 'package:dochelp/Worker/Worker_AppointmentScreen.dart';
import 'package:flutter/material.dart';
import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';

class WorkerBottomBar extends StatefulWidget {
String currentId;
WorkerBottomBar({super.key, 
  required this.currentId
});
  @override
  _WorkerBottomBarState createState() => _WorkerBottomBarState();
}

class _WorkerBottomBarState extends State<WorkerBottomBar> {
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
      backgroundColor:Colors.white,
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        children: [
          WorkerAppointmentscreen(currentid: widget.currentId,),
           WorkerProfile(),
             ],
      ),
      bottomNavigationBar: AnimatedNotchBottomBar(
        notchBottomBarController: _notchBottomBarController,
        bottomBarItems: [
         
            BottomBarItem(
            inActiveItem: Icon(
              Icons.calendar_month_outlined,
              color: Colors.blueGrey,
            ),
            activeItem: Icon(
              Icons.calendar_month,
              color:Color(0xFF2C41FF),
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
              color:Color(0xFF2C41FF),
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
