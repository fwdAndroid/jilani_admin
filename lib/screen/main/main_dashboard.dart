import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jilani_admin/screen/main/pages/home_page.dart';
import 'package:jilani_admin/screen/main/pages/reports_support.dart';
import 'package:jilani_admin/screen/main/pages/setting_page.dart';
import 'package:jilani_admin/utils/color.dart';

class MainDashboard extends StatefulWidget {
  @override
  _MainDashboardState createState() => _MainDashboardState();
}

class _MainDashboardState extends State<MainDashboard> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    HomePage(),
    ReportsSupport(),
    SettingPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedLabelStyle: TextStyle(color: mainColor),
        backgroundColor: mainColor,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: _currentIndex == 0 ? colorWhite : Colors.grey,
            ),
            label: 'Home',
            backgroundColor: mainColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.trip_origin,
              color: _currentIndex == 1 ? mainColor : Colors.grey,
            ),
            label: 'Orders',
            backgroundColor: mainColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              color: _currentIndex == 3 ? mainColor : Colors.grey,
            ),
            label: 'Account',
            backgroundColor: mainColor,
          ),
        ],
      ),
    );
  }
}
