import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'resource/Home/home_page.dart';
import 'resource/Profile/account_page.dart';

Widget buildBottomNavigationBar(int _currentIndex, BuildContext context) {
  return CustomNavigationBar(
    iconSize: 30.0,
    selectedColor: const Color.fromRGBO(20, 160, 240, 1.0),
    strokeColor: const Color(0x30040307),
    unSelectedColor: const Color(0xffacacac),
    backgroundColor: Colors.white12,
    items: [
      CustomNavigationBarItem(
        icon: const Icon(Icons.home),
        title: const Text("Home"),
      ),
      CustomNavigationBarItem(
        icon: const Icon(Icons.account_circle),
        title: const Text("Profile"),
      ),
    ],
    currentIndex: _currentIndex,
    onTap: (index) {
      if (index == _currentIndex) return;
      if (index == 0) {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const HomeScreen()));
      } else if (index == 1) {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const AccountPage()));
      }
    },
  );
}
