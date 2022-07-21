import 'package:flutter/material.dart';
import 'package:tiktok_clone/const.dart';

import '../widgets/custom_icon.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int indexNumber = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgrounColor,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: backgrounColor,
        selectedItemColor: buttonColor,
        unselectedItemColor: Colors.white,
        currentIndex: indexNumber,
        onTap: (idx){
          setState(() {
            indexNumber = idx;
          });
        },
        type: BottomNavigationBarType.fixed,
        items: [
        BottomNavigationBarItem(
          
            icon: Icon(
              Icons.home,
              size: 30,
            ),
            label: 'Home'),
              BottomNavigationBarItem(
            icon: Icon(
              Icons.search,
              size: 30,
            ),
            label: 'Search'),
              BottomNavigationBarItem(
            icon: CustomIcon(),
            label: ''),
              BottomNavigationBarItem(
            icon: Icon(
              Icons.message,
              size: 30,
            ),
            label: 'Messages'),
               BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              size: 30,
            ),
            label: 'Profile'),
      ]),
      body: pages[indexNumber],
    );
  }
}
